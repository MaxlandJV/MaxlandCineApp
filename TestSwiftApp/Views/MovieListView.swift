//
//  MovieListView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 14/3/22.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var movieViewModel = MovieViewModel()
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            LinearGradient(colors: [Color("TopColorGradient"), Color("BottomColorGradient")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .overlay(
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
                        .navigationTitle(Text("Películas"))
                        .navigationBarItems(leading: NavigationLink(destination: MovieSetupView()) {
                            Image(systemName: "gearshape")
                        })
                        .navigationBarItems(trailing: Button {
                            isPresented.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.black)
                        })
                        .sheet(isPresented: $isPresented) {
                            MovieView(update: false)
                        }
                )
        }
        .environmentObject(movieViewModel)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}