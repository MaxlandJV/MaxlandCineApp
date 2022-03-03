//
//  MovieView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct MovieView: View {
    @Environment(\.dismiss) var dismiss
    
    @FocusState var movieNameInfocus: Bool // @FocusState no se tiene que inicializar, solamente definir
    
    @State var movieName = ""
    @State var startDate = Date()
    @State var sinopsis = ""
    @State var score = 0
    @State var movie: MovieModel?
    @State var showingAlert = false
    
    @ObservedObject var movies: MoviesViewModel
    
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
                    .focused($movieNameInfocus)
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
                .colorMultiply(.white)
                .cornerRadius(10)
            if !update {
                HStack {
                    Button(action: newMovie, label: {
                        Label("Guardar", systemImage: "doc.fill.badge.plus")
                            .padding(.horizontal)
                    })
                        .buttonStyle(.borderedProminent)
                        .alert("El nombre de la película es un dato obligatorio.", isPresented: $showingAlert) {}
                    
                    Button(action: { dismiss() }) {
                        Label("Cancelar", systemImage: "xmark")
                            .padding(.horizontal)
                    }
                    .buttonStyle(.bordered)
                }
            }
            else {
                Button(action: updateMovie, label: {
                    Label("Actualizar", systemImage: "doc.badge.gearshape.fill")
                        .padding(.horizontal)
                })
                    .buttonStyle(.borderedProminent)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(movie?.movieName ?? "", displayMode: .inline)
        .onAppear {
            if let updatedMovie = movie {
                movieName = updatedMovie.movieName
                startDate = updatedMovie.startDate
                sinopsis = updatedMovie.sinopsis
                score = updatedMovie.score
            } else {
                // Poner el foco en el campo del nombre de la película
                // Si se cambia el valor de "movieNameInFocus" no funciona
                // Hay que hacerlo desde algún disparador como un botón
                // o en este caso desde un evento asíncrono
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    movieNameInfocus = true
                }
            }
        }
    }
    
    // MARK: Crear nueva película
    func newMovie() {
        if (movieName.isEmpty) {
            showingAlert = true
        } else {
            movies.saveMovie(movieName: movieName, startDate: startDate, sinopsis: sinopsis, score: score)
            dismiss()
        }
    }
    
    // MARK: Actualizar una película existente
    func updateMovie() {
        if let updatedMovie = movie {
            movies.updateMovie(movieId: updatedMovie.id, movieName: movieName, startDate: startDate, sinopsis: sinopsis, score: score)
        }
        dismiss()
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        let movies = MoviesViewModel()
        MovieView(movies: movies, update: false)
    }
}
