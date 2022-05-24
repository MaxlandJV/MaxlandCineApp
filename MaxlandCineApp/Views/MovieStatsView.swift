//
//  MovieStatsView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 24/5/22.
//

import SwiftUI

struct MovieStatsView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    @State private var movieListScore: [Int] = []
    @State private var score = 0
    
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
                            .fill(Color.blue.opacity(0.6))
                            .frame(width: 20, height: 8)
                        Text("stats-movie-score")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 0) {
                        ForEach(Array(movieListScore.enumerated()), id: \.offset) { index, movieScore in
                            VStack {
                                Text("\(movieScore)")
                                    .font(.headline)
                                Capsule()
                                    .fill(Color.blue.opacity(0.6))
                                    .frame(width: 18)
                                    .frame(height: getBarHeight(valor: CGFloat(movieScore)))
                                Text("\(index+1)")
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        }
                    }
                    .padding(.top, 20)
                    .frame(height: 280)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(18)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
        .navigationBarTitle("stats-title")
        .onAppear {
            movieListScore = movieViewModel.getNumberMoviesByScore()
            print(movieListScore)
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
        let height = (valor * 180) / max
        
        return height
    }
}

struct MovieStatsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieStatsView()
    }
}
