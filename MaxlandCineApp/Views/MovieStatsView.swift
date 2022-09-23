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
                MovieStatsViewGraph(TitleText: Text("stats-total-number"), numberOfMovies: movieViewModel.getNumberMovies(type: MovieViewModel.typeData.All), movieListScore: movieViewModel.getNumberMoviesByScore())
                MovieStatsViewGraph(TitleText: Text("stats-movie-number"), numberOfMovies: movieViewModel.getNumberMovies(type: MovieViewModel.typeData.Movies), movieListScore: movieViewModel.getNumberMoviesByScore())
                MovieStatsViewGraph(TitleText: Text("stats-serie-number"), numberOfMovies: movieViewModel.getNumberMovies(type: MovieViewModel.typeData.Series), movieListScore: movieViewModel.getNumberMoviesByScore())
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
