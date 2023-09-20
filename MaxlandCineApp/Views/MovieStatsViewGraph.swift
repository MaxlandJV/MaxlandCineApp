//
//  MovieStatsViewGraph.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 20/9/22.
//

import SwiftUI
import Charts

struct Info: Identifiable {
    let id: String = UUID().uuidString
    let starsNumber: Int
    let movies: Int
}

struct MovieStatsViewGraph: View {
    
    var TitleText: Text
    var numberOfMovies: Int
    var movieListScore: [Int] = [0,0,0,0,0]
    @State private var graphInfo: [Info] = []
    @State private var showMoviesByScore = false
    @State private var texto = ""
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                HStack {
                    TitleText
                        .font(.headline)
                    Spacer()
                    Text("\(numberOfMovies)")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                HStack {
                    Capsule()
                        .fill(Color.blue)
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
                    .foregroundStyle(Color.blue.gradient)
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
                .frame(height: 280)
                .chartOverlay { proxy in
                    GeometryReader { geometry in
                        ZStack(alignment: .top) {
                            Rectangle().fill(.clear).contentShape(Rectangle())
                                .onTapGesture { location in
                                    let xPos = location.x - geometry[proxy.plotAreaFrame].origin.x
                                    guard let xbar: String = proxy.value(atX: xPos) else { return }
                                    showMoviesByScore = true
                                    texto = getMoviesByScore(score: xbar)
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
            HStack {
                ScrollView(.horizontal) {
                    Label(
                        title: { Text(texto) },
                        icon: { /*@START_MENU_TOKEN@*/Image(systemName: "42.circle")/*@END_MENU_TOKEN@*/ }
                    )
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(18)
        }
    }
    
    func getMoviesByScore(score: String) -> String {
        return score
    }
}

#Preview {
    MovieStatsViewGraph(TitleText: Text("Prueba"), numberOfMovies: 5, movieListScore: [1,3,8,4,2])
}
