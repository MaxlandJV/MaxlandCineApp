//
//  MovieListView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 14/3/22.
//

import SwiftUI

struct MovieListView: View {
    
    @State var isPresented: Bool = false
    @State var searchMovie: String = ""
    @State private var selectedMovie: MovieItem?
    @State private var columnVisibility = NavigationSplitViewVisibility.all
    
    @Environment(MovieViewModel.self) var movieViewModel: MovieViewModel
    
    var searchResults: [MovieItem] {
        if searchMovie.isEmpty {
            return movieViewModel.movieList
        } else {
            let lowercaseSearchMovie = searchMovie.lowercased()
            return movieViewModel.movieList.filter { movie -> Bool in
                return movie.movieName.lowercased().contains(lowercaseSearchMovie)
            }
        }
    }
    
    var body: some View {      
        NavigationSplitView(columnVisibility: $columnVisibility) {
            ZStack {
                if movieViewModel.movieList.isEmpty {
                    LinearGradient(colors: [Color("TopColorGradient"), Color("BottomColorGradient")], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                        .overlay (
                            MovieEmptyView(isPresented: $isPresented)
                                .transition(AnyTransition.opacity.animation(.easeIn)))
                }
                else {
                    List(searchResults, selection: $selectedMovie) {movie in
                        NavigationLink(value: movie) {
                            MovieListRowView(movieName: movie.movieName, showDate: movie.showDate, sinopsis: movie.sinopsis, score: movie.score, isSerie: movie.isSerie, caratula: movie.caratula)
                                .contextMenu {
                                    Button {
                                        movieViewModel.deleteMovie(movie: movie)
                                    } label: {
                                        Label("movie-confirm-delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    .searchable(text: $searchMovie, prompt: "navigation-list-search")
                    .listStyle(.plain)
                    
//                    ScrollView {
//                        LazyVStack {
//                            ForEach(searchResults) { movie in
//                                NavigationLink(value: movie) {
//                                    MovieListRowView(movieName: movie.movieName, showDate: movie.showDate, sinopsis: movie.sinopsis, score: movie.score, isSerie: movie.isSerie, caratula: movie.caratula)
//                                        .contextMenu {
//                                            Button {
//                                                movieViewModel.deleteMovie(movie: movie)
//                                            } label: {
//                                                Label("movie-confirm-delete", systemImage: "trash")
//                                            }
//                                        }
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//                        .frame(maxWidth: .infinity)
//                    }
//                    .searchable(text: $searchMovie, prompt: "navigation-list-search")
//                    .navigationDestination(for: MovieItem.self) { movie in
//                        MovieView(movie: movie, update: true)
//                    }
                }
            }
            .background(LinearGradient(colors: [Color("TopColorGradient"), Color("BottomColorGradient")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .navigationTitle(Text("navigation-list-title"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: MovieSetupView(movieViewModel: movieViewModel)) {
                        Image(systemName: "gearshape").foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if (movieViewModel.movieList.count > 0) {
                        NavigationLink(destination: MovieStatsView()) {
                            Image(systemName: "chart.bar.xaxis").foregroundColor(.black)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus.circle").foregroundColor(.black)
                    }
                }
            }
            .sheet(isPresented: $isPresented) {
                NavigationStack {
                    MovieView()
                        .interactiveDismissDisabled()
                }
                .presentationBackground(.thinMaterial)
            }
        } detail: {
            if let movie = selectedMovie {
                MovieView(movie: movie, update: true)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            movieViewModel.fetchMovies()
        }
    }
}

#Preview {
    MovieListView()
        .environment(MovieViewModel())
}
