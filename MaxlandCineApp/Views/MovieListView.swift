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
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    var searchResults: [Movie] {
        if searchMovie.isEmpty {
            return movieViewModel.movieList
        } else {
            let lowercaseSearchMovie = searchMovie.lowercased()
            return movieViewModel.movieList.filter { movie -> Bool in
                if let movieName = movie.movieName {
                    return movieName.lowercased().contains(lowercaseSearchMovie)
                }
                return false
            }
        }
    }
    
    var body: some View {
        
//        NavigationStack {
//            ScrollView {
//                ForEach(searchResults) { movie in
//                    NavigationLink(destination: MovieView(movie: movie, update: true)) {
//                        MovieListRowView(movieName: movie.movieName, showDate: movie.showDate, sinopsis: movie.sinopsis, score: movie.score, isSerie: movie.isSerie)
//                    }
//                    .swipeActions(edge: .leading) {
//                        Button {
//                            movieViewModel.deleteMovie(movie: movie)
//                        } label: {
//                            Label("Eliminar", systemImage: "trash.fill")
//                        }
//                        .tint(.red)
//                    }
//                }
//                .searchable(text: $searchMovie, prompt: "navigation-list-search")
//            }
//            .navigationTitle(Text("navigation-list-title"))
//            .toolbar(content: {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    NavigationLink(destination: MovieSetupView()) {
//                        Image(systemName: "gearshape").foregroundColor(.black)
//                    }
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    if (movieViewModel.movieList.count > 0) {
//                        NavigationLink(destination: MovieStatsView()) {
//                            Image(systemName: "chart.bar.xaxis").foregroundColor(.black)
//                        }
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        isPresented.toggle()
//                    } label: {
//                        Image(systemName: "plus.circle").foregroundColor(.black)
//                    }
//                }
//            })
//            .sheet(isPresented: $isPresented) {
//                MovieView()
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())

        NavigationView {
           LinearGradient(colors: [Color("TopColorGradient"), Color("BottomColorGradient")], startPoint: .topLeading, endPoint: .bottomTrailing)
               .ignoresSafeArea()
               .overlay (
                    ZStack {
                        if movieViewModel.movieList.isEmpty {
                            MovieEmptyView()
                                .transition(AnyTransition.opacity.animation(.easeIn))
                        }
                        else {
                            VStack {
                                List(searchResults) { movie in
                                    NavigationLink(destination: MovieView(movie: movie, update: true)) {
                                        MovieListRowView(movieName: movie.movieName, showDate: movie.showDate, sinopsis: movie.sinopsis, score: movie.score, isSerie: movie.isSerie)
                                    }
                                    .swipeActions(edge: .leading) {
                                        Button {
                                            movieViewModel.deleteMovie(movie: movie)
                                        } label: {
                                            Label("Eliminar", systemImage: "trash.fill")
                                        }
                                        .tint(.red)
                                    }
                                    .listRowBackground(Color.white.opacity(0))
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
                                }
                                .scrollContentBackground(.hidden)
                                .listStyle(.plain)
                                .searchable(text: $searchMovie, prompt: "navigation-list-search")
                            }
                        }
                    }
                    //.background(Color.green)
                    .navigationTitle(Text("navigation-list-title"))
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink(destination: MovieSetupView()) {
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
                    })
                    .sheet(isPresented: $isPresented) {
                        MovieView()
                    }
                )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
            .environmentObject(MovieViewModel())
    }
}
