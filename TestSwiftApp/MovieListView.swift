//
//  MovieListView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI
import CoreData

struct MovieListView: View {
    @StateObject var movieViewModel = MovieViewModel()
    @State var isPresented: Bool = false
       
    var body: some View {
        NavigationView {
            LinearGradient(colors: [Color(#colorLiteral(red: 0.4905710816, green: 0.8656919599, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .overlay(
                    List(movieViewModel.movieList) { movie in
                            NavigationLink(destination: MovieView(movie: movie, movieViewModel: movieViewModel, update: true)) {
                            MovieListRowView(movie: movie)
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
                    .navigationBarItems(trailing: Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    })
                    .sheet(isPresented: $isPresented) {
                        MovieView(movieViewModel: movieViewModel, update: false)
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
