//
//  MovieListView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 14/3/22.
//

import SwiftUI

struct MovieListView: View {
    
    @State var searchMovie: String = ""
    @State var isPresented: Bool = false
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    var body: some View {
        NavigationView {
            LinearGradient(colors: [Color("TopColorGradient"), Color("BottomColorGradient")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .overlay(
                    ZStack {
                        if movieViewModel.movieList.isEmpty {
                            MovieEmptyView()
                                .transition(AnyTransition.opacity.animation(.easeIn))
                        }
                        else {
                            VStack {
                                TextField("Buscar una película", text: $searchMovie)
                                    .padding(8)
                                    .background(Color(UIColor.systemGray3))
                                    .cornerRadius(10)
                                    .disableAutocorrection(true)
                                    .padding()
                                List(movieViewModel.movieList) { movie in
                                    NavigationLink(destination: MovieView(movie: movie, update: true)) {
                                        MovieListRowView(movieName: movie.movieName, showDate: movie.showDate, sinopsis: movie.sinopsis, score: movie.score)
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
                                }
                                    .listStyle(PlainListStyle())
                            }
                        }
                    }
                        .navigationTitle(Text("Películas"))
                        .navigationBarItems(leading: NavigationLink(destination: MovieSetupView()) {
                            Image(systemName: "gearshape")
                                .foregroundColor(.black)
                        })
                        .navigationBarItems(trailing: Button {
                            isPresented.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.black)
                        })
                        .sheet(isPresented: $isPresented) {
                            MovieView()
                        }
                )
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
