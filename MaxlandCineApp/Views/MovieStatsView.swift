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
    
    var body: some View {
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
            }
            .padding()
            .background(Color.white)
            .cornerRadius(18)
            
            Spacer()
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
}

struct MovieStatsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieStatsView()
    }
}
