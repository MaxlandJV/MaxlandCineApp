//
//  MovieStatsGraphView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 20/9/22.
//

import SwiftUI
import Charts

struct MovieStatsGraphView: View {
    @Environment(MovieViewModel.self) var movieViewModel: MovieViewModel
    
    var titleText: Text
    var numberOfMovies: Int
    var movieListScore: [Int] = [0,0,0,0,0]
    var type: MovieViewModel.typeData
    @State private var graphInfo: [Info] = []
    @State private var showMoviesByScore = false
    @State private var selectedScoreMovieList: [MovieItem] = []
    @State private var starsNumber: Int = 0
    @State private var barSelected: [Bool] = [false, false, false, false, false]
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                HStack {
                    titleText
                        .font(.headline)
                    Spacer()
                    Text("\(numberOfMovies)")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                HStack {
                    Capsule()
                        .fill(Color.blue.gradient)
                        .frame(width: 20, height: 8)
                    Text("stats-score")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Chart(graphInfo) { data in
                    BarMark(x: .value("Stars", "\(data.starsNumber)"),
                            y: .value("Views", data.movies))
                    .annotation(position: .top, alignment: .center) {
                        Text("\(data.movies)")
                            .font(.headline)
                    }
                    .foregroundStyle((barSelected[data.starsNumber - 1]) ? Color.green.gradient : Color.blue.gradient)
                }
                .chartXAxis {
                    AxisMarks() { axisValue in
                        if let valor = axisValue.as(String.self) {
                            AxisValueLabel {
                                let ivalor = Int(valor) ?? 0
                                HStack(spacing: 0) {
                                    ForEach(1...ivalor, id: \.self) { number in
                                        Image(systemName: "star.fill").foregroundColor(.orange)
                                    }
                                }
                                .font(.system(size: 7))
                            }
                        }
                    }
                }
                .frame(height: 260)
                .chartOverlay { proxy in
                    GeometryReader { geometry in
                        ZStack(alignment: .top) {
                            Rectangle().fill(.clear).contentShape(Rectangle())
                                .onTapGesture { location in
                                    guard let plot = proxy.plotFrame else { return }
                                    let xPos = location.x - geometry[plot].origin.x
                                    guard let xbar: String = proxy.value(atX: xPos) else { return }
                                    starsNumber = Int(xbar) ?? 0
                                    barSelected = [false, false, false, false, false]
                                    barSelected[starsNumber - 1] = true
                                    selectedScoreMovieList = movieViewModel.getMoviesByScore(type: type, score: starsNumber)
                                    withAnimation(.default) {
                                        showMoviesByScore = selectedScoreMovieList.count > 0
                                    }
                                }
                        }
                    }
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(18)
        }
        .onAppear {
            graphInfo.removeAll()
            for index in 0...4 {
                withAnimation(.easeInOut(duration: 0.8).delay(Double(index) * 0.05)) {
                    graphInfo.append(Info(starsNumber: index + 1, movies: movieListScore[index]))
                }
            }
        }
        
        if showMoviesByScore {
            VStack {
                Label(
                    title: { Text("stats-stars") },
                    icon: { Image(systemName: "\(starsNumber).circle") }
                ).font(.headline)
                    
                MovieStatsScoreView(selectedScoreMovieList: selectedScoreMovieList)
            }
        }
    }
}

#Preview {
    MovieStatsGraphView(titleText: Text("Prueba"), numberOfMovies: 5, movieListScore: [1,3,8,4,2], type: MovieViewModel.typeData.All)
        .environment(MovieViewModel())
}
