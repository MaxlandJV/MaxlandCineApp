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
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            LinearGradient(colors: [Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .overlay(
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
                            isPresented.toggle()
                        } label: {
                            Image(systemName: "plus.circle")
                        })
                        .sheet(isPresented: $isPresented) {
                            MovieView(movies: movies, update: false)
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
