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
                        MovieStatsGraphBarView(starsNumber: 1, movies: movieListScore[0], score: score[0])
                        MovieStatsGraphBarView(starsNumber: 2, movies: movieListScore[1], score: score[1])
                        MovieStatsGraphBarView(starsNumber: 3, movies: movieListScore[2], score: score[2])
                        MovieStatsGraphBarView(starsNumber: 4, movies: movieListScore[3], score: score[3])
                        MovieStatsGraphBarView(starsNumber: 5, movies: movieListScore[4], score: score[4])
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
