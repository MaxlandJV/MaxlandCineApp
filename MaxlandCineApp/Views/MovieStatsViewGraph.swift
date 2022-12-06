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
    }
}

struct MovieStatsViewGraph_Previews: PreviewProvider {
    static var previews: some View {
        MovieStatsViewGraph(TitleText: Text("Prueba"), numberOfMovies: 5)
    }
}
