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
    let score: CGFloat
}

var graphInfo: [Info] = []

struct MovieStatsViewGraph: View {
    
    var TitleText: Text
    var numberOfMovies: Int
    var movieListScore: [Int] = [0,0,0,0,0]
    @State private var score: [CGFloat] = [0,0,0,0,0]
    
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
                
                HStack(spacing: 0) {
                    MovieStatsGraphBarView(starsNumber: 1, movies: movieListScore[0], score: score[0])
                    MovieStatsGraphBarView(starsNumber: 2, movies: movieListScore[1], score: score[1])
                    MovieStatsGraphBarView(starsNumber: 3, movies: movieListScore[2], score: score[2])
                    MovieStatsGraphBarView(starsNumber: 4, movies: movieListScore[3], score: score[3])
                    MovieStatsGraphBarView(starsNumber: 5, movies: movieListScore[4], score: score[4])
                }
                .padding(.top, 20)
                .frame(height: 280)
                
                
                Chart(graphInfo) { data in
                    BarMark(x: .value("*", data.starsNumber),
                            y: .value("Views", data.movies))
                    .annotation(position: .top, alignment: .center) {
                        Text("\(data.movies)")
                            .font(.headline)
                    }
                }
                .chartXAxis {
                    AxisMarks() { axisValue in
                        AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 1))
                        if let valor = axisValue.as(Int.self) {
                            AxisValueLabel {
                                Text("\(valor)")
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
            withAnimation(.linear(duration: 0.5)) {
                score[0] = getBarHeight(valor: CGFloat(movieListScore[0]))
                score[1] = getBarHeight(valor: CGFloat(movieListScore[1]))
                score[2] = getBarHeight(valor: CGFloat(movieListScore[2]))
                score[3] = getBarHeight(valor: CGFloat(movieListScore[3]))
                score[4] = getBarHeight(valor: CGFloat(movieListScore[4]))
                
                graphInfo.append(Info(starsNumber: 1, movies: movieListScore[0], score: score[0]))
                graphInfo.append(Info(starsNumber: 2, movies: movieListScore[1], score: score[1]))
                graphInfo.append(Info(starsNumber: 3, movies: movieListScore[2], score: score[2]))
                graphInfo.append(Info(starsNumber: 4, movies: movieListScore[3], score: score[3]))
                graphInfo.append(Info(starsNumber: 5, movies: movieListScore[4], score: score[4]))
            }
        }
    }
    
    // MARK: Obtener el valor máximo
    func getMax() -> CGFloat {
        let max = movieListScore.max { valor1, valor2 in
            return valor2 > valor1
        } ?? 0
        
        return CGFloat(max)
    }
    
    // MARK: Obtener el tamaño de cada barra del gráfico
    func getBarHeight(valor: CGFloat) -> CGFloat {
        let max = getMax()
        let height = max > 0 ? (valor * 180) / max : 0
        
        return height
    }
}

struct MovieStatsViewGraph_Previews: PreviewProvider {
    static var previews: some View {
        MovieStatsViewGraph(TitleText: Text("Prueba"), numberOfMovies: 5)
    }
}
