//
//  MovieStatsView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 24/5/22.
//

import SwiftUI

struct MovieStatsView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    @State private var movieListScore: [Int] = [0,0,0,0,0]
    @State private var score: [CGFloat] = [0,0,0,0,0]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(spacing: 20) {
                    HStack {
                        Text("stats-movie-number")
                            .font(.headline)
                        Spacer()
                        Text("\(movieViewModel.getNumberMovies())")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    
                    HStack {
                        Capsule()
                            .fill(Color.blue)
                            .frame(width: 20, height: 8)
                        Text("stats-movie-score")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 0) {
                        VStack {
                            Text("\(movieListScore[0])")
                                .font(.headline)
                            Capsule()
                            //.fill(Color.blue.opacity(0.5 + CGFloat(Double(index) / 10.0)))
                                .fill(Color.blue.opacity(0.5))
                                .frame(width: 18, height: score[0])
                            HStack(spacing: 0) {
                                Text("\(1)")
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                            }
                            .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                
                        VStack {
                            Text("\(movieListScore[1])")
                                .font(.headline)
                            Capsule()
                                .fill(Color.blue.opacity(0.6))
                                .frame(width: 18, height: score[1])
                            HStack(spacing: 0) {
                                Text("\(2)")
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                            }
                            .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    
                        VStack {
                            Text("\(movieListScore[2])")
                                .font(.headline)
                            Capsule()
                                .fill(Color.blue.opacity(0.7))
                                .frame(width: 18, height: score[2])
                            HStack(spacing: 0) {
                                Text("\(3)")
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                            }
                            .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    
                        VStack {
                            Text("\(movieListScore[3])")
                                .font(.headline)
                            Capsule()
                                .fill(Color.blue.opacity(0.8))
                                .frame(width: 18, height: score[3])
                            HStack(spacing: 0) {
                                Text("\(4)")
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                            }
                            .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    
                        VStack {
                            Text("\(movieListScore[4])")
                                .font(.headline)
                            Capsule()
                                .fill(Color.blue.opacity(0.9))
                                .frame(width: 18, height: score[4])
                            HStack(spacing: 0) {
                                Text("\(5)")
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                            }
                            .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                            
                    }
                    .padding(.top, 20)
                    .frame(height: 280)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(18)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray5))
        .navigationBarTitle("stats-title")
        .onAppear {
            movieListScore = movieViewModel.getNumberMoviesByScore()
            withAnimation(.linear(duration: 0.5)) {
                score[0] = getBarHeight(valor: CGFloat(movieListScore[0]))
                score[1] = getBarHeight(valor: CGFloat(movieListScore[1]))
                score[2] = getBarHeight(valor: CGFloat(movieListScore[2]))
                score[3] = getBarHeight(valor: CGFloat(movieListScore[3]))
                score[4] = getBarHeight(valor: CGFloat(movieListScore[4]))
            }
        }
    }
    
    // MARK: Obtener el valor máximo
    func getMax() -> Int {
        let max = movieListScore.max { valor1, valor2 in
            return valor2 > valor1
        } ?? 0
        
        return max
    }
    
    // MArK: Obtener el tamaño de cada barra del gráfico
    func getBarHeight(valor: CGFloat) -> CGFloat {
        let max = CGFloat(getMax())
        let height = max > 0 ? (valor * 180) / max : 0
        
        return height
    }
}

struct MovieStatsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieStatsView()
    }
}
