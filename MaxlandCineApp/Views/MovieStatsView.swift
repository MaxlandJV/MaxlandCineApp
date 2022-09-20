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
                MovieStatsViewGraph(numberOfMovies: movieViewModel.getNumberMovies(), movieListScore: movieViewModel.getNumberMoviesByScore())
                MovieStatsViewGraph(numberOfMovies: movieViewModel.getNumberMovies(), movieListScore: movieViewModel.getNumberMoviesByScore())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray5))
        .navigationBarTitle("stats-title")
    }
}

struct MovieStatsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieStatsView()
    }
}
