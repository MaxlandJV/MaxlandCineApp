//
//  MovieListView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var movies = MoviesViewModel()
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List(movies.movieList) { movieItem in
                NavigationLink(destination: MovieView(movie: movieItem, movies: movies, update: true)) {
                    MovieListRowView(movie: movieItem)
                }
                .swipeActions(edge: .leading) {
                    Button {
                        movies.deleteMovie(id: movieItem.id)
                    } label: {
                        Label("Eliminar", systemImage: "trash.fill")
                    }
                    .tint(.red)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle(Text("Películas"))
            .navigationBarItems(trailing: Button {
                isPresented = true
            } label: {
                Text("Añadir película")
            })
            .sheet(isPresented: $isPresented, onDismiss: {
                isPresented = false
            }, content: {
                MovieView(movies: movies, update: false)
            })
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
