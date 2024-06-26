//
//  MovieStatsView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 24/5/22.
//

import SwiftUI

struct MovieStatsView: View {
    @Environment(MovieViewModel.self) var movieViewModel: MovieViewModel
    
    @State private var graphOption = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                switch graphOption {
                case 1:MovieStatsGraphView(titleText: Text("stats-movie-number"), numberOfMovies: movieViewModel.getNumberMovies(type: MovieViewModel.typeData.Movies), movieListScore: movieViewModel.getNumberMoviesByScore(type: MovieViewModel.typeData.Movies), type: MovieViewModel.typeData.Movies)
                case 2:MovieStatsGraphView(titleText: Text("stats-serie-number"), numberOfMovies: movieViewModel.getNumberMovies(type: MovieViewModel.typeData.Series), movieListScore: movieViewModel.getNumberMoviesByScore(type: MovieViewModel.typeData.Series), type: MovieViewModel.typeData.Series)
                default:
                    MovieStatsGraphView(titleText: Text("stats-total-number"), numberOfMovies: movieViewModel.getNumberMovies(type: MovieViewModel.typeData.All), movieListScore: movieViewModel.getNumberMoviesByScore(type: MovieViewModel.typeData.All), type: MovieViewModel.typeData.All)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray5))
        .navigationBarTitle("stats-title")
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Picker(selection: $graphOption, label: Text("")) {
                        Label("stats-todo", systemImage: "list.bullet.rectangle").tag(0)
                        Label("stats-movies", systemImage: "film").tag(1)
                        Label("stats-series", systemImage: "sparkles.tv").tag(2)
                    }
                }
                label: {
                    Image(systemName: "filemenu.and.selection")
                }
            }
        })
    }
}

#Preview {
    NavigationStack {
        MovieStatsView()
            .environment(MovieViewModel())
    }
}
