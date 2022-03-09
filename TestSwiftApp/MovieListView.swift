//
//  MovieListView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var movieViewModel = MovieViewModel()
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            LinearGradient(colors: [Color(#colorLiteral(red: 0.4905710816, green: 0.8656919599, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .overlay(
                    List(movieViewModel.movieList) { movie in
                        NavigationLink(destination: MovieView(movie: movie, update: true)) {
                            //VStack {
                            //MovieListRowView(movie: movie)
                            HStack {
                                Image(systemName: "film").font(.title)
                                VStack(alignment: .leading) {
                                    Text(movie.movieName ?? "").font(.subheadline).bold()
                                    HStack {
                                        HStack(spacing: 0) {
                                            ForEach(1...5, id: \.self) { number in
                                                Image(systemName: "star.fill")
                                                    .font(.caption2)
                                                    .foregroundColor(number > movie.score ? Color(.systemGray6) : .yellow)
                                            }
                                        }
                                        Text("-")
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                        Text(movie.showDate ?? Date(), style: .date)
                                            .font(.caption2)
                                            .foregroundColor(Color.black)
                                    }
                                }
                            }
                            //}
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
