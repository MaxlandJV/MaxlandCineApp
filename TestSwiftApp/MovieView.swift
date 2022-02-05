//
//  MovieView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct MovieView: View {
    @Environment(\.dismiss) var dismiss
    @State var movieName = ""
    @State var startDate = Date()
    @State var sinopsis = ""
    @State var score = 0
    @State var movie: MovieModel
    @StateObject var movies: MoviesViewModel
    var update: Bool
    
    var body: some View {
        VStack {
            // Cambiar Form por List para poder aplicar estilos al formulario con .listStyle
            List {
                Section(header: Text("Película")) {
                    if !update { TextField("Nombre de la película", text: $movieName) }
                    DatePicker("Fecha de estreno",selection: $startDate, displayedComponents: .date)
                    Stepper("Puntuación: \(score)", value: $score, in: 0...5)
                }
                Section(header: Text("Sinopsis")) {
                    TextEditor(text: $sinopsis)
                        .frame(height: 200)
                }
            }
            .listStyle(.grouped)
            if !update {
                Button {
                    movies.saveMovie(movieName: movieName, startDate: startDate, sinopsis: sinopsis, score: score)
                    dismiss()
                } label: {
                    Label("Guardar", systemImage: "doc.fill.badge.plus")
                        .padding()
                }.buttonStyle(.bordered)
            }
            else {
                Button {
                    movies.updateMovie(movieId: movie.id, movieName: movieName, startDate: startDate, sinopsis: sinopsis, score: score)
                    dismiss()
                } label: {
                    Label("Actualizar", systemImage: "doc.fill.badge.plus")
                        .padding()
                }.buttonStyle(.bordered)
            }
        }
        .navigationTitle(movie.movieName)
        .onAppear{
            movieName = movie.movieName
            startDate = movie.startDate
            sinopsis = movie.sinopsis
            score = movie.score
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        let movies = MoviesViewModel()
        let movie = MovieModel(movieName: "", startDate: Date(), sinopsis: "", score: 0)
        MovieView(movie: movie, movies: movies, update: false)
    }
}
