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
    @State var movie: MovieModel?
    @State var showingAlert = false
    @StateObject var movies: MoviesViewModel
    var update: Bool
    
    var body: some View {
        VStack {
            if !update {
                HStack {
                    Text("Nueva película")
                        .padding(.vertical, 10)
                        .font(.title2)
                    Spacer()
                }
                TextField("Nombre de la película", text: $movieName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .disableAutocorrection(true)
            }
            DatePicker("Fecha de estreno",selection: $startDate, displayedComponents: .date)
                .padding(.vertical)
            Stepper("Puntuación: \(score)", value: $score, in: 0...5)
                .padding(.vertical)
            Spacer()
            HStack() {
                Text("Sinopsis:")
                    .font(.headline)
                Spacer()
            }
            TextEditor(text: $sinopsis)
                .frame(maxHeight: .infinity)
                .colorMultiply(.white)
                .cornerRadius(10)
            Spacer()
            if !update {
                Button {
                    if (movieName.isEmpty) {
                        showingAlert = true
                    }
                    else {
                        movies.saveMovie(movieName: movieName, startDate: startDate, sinopsis: sinopsis, score: score)
                        dismiss()
                    }
                } label: {
                    Label("Guardar", systemImage: "doc.fill.badge.plus")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                }
                .buttonStyle(.bordered)
                .alert("El nombre de la película es un dato obligatorio.", isPresented: $showingAlert) {}
            }
            else {
                Button {
                    movies.updateMovie(movieId: movie!.id, movieName: movieName, startDate: startDate, sinopsis: sinopsis, score: score)
                    dismiss()
                } label: {
                    Label("Actualizar", systemImage: "doc.badge.gearshape.fill")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                }
                .buttonStyle(.bordered)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(movie != nil ? movie!.movieName : "", displayMode: .inline)
        .onAppear {
            if movie != nil {
                movieName = movie!.movieName
                startDate = movie!.startDate
                sinopsis = movie!.sinopsis
                score = movie!.score
            }
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        let movies = MoviesViewModel()
        MovieView(movies: movies, update: false)
    }
}
