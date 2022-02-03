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
                    HStack {
                        Image(systemName: "film").font(.title)
                        VStack(alignment: .leading) {
                            Text(movieItem.movieName).font(.caption).bold()
                            Text(movieItem.startDate, style: .date).font(.caption2).foregroundColor(.gray)
                        }
                        .padding(.leading, 3)
                        Spacer()
                        HStack {
                            ForEach(1...5, id: \.self) { number in
                                Image(systemName: "star.fill")
                                    .font(.caption2)
                                    .foregroundColor(number > movieItem.score ? Color(.systemGray6) : .yellow)
                                    .padding(.trailing, -8)
                            }
                        }
                        .padding(.trailing, 10)
                    }
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
                let film = MovieModel(movieName: "", startDate: Date(), sinopsis: "", score: 0)
                MovieView(movie: film, movies: movies, update: false)
            })
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
