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
    @State var showDate = Date()
    @State var sinopsis = ""
    @State var score: Int16 = 0
    @State var movie: MovieModel?
    @State var showingAlert = false
    
    @ObservedObject var movieViewModel: MovieCoreDataViewModel
    
    var update: Bool
    
    var body: some View {
        VStack(spacing: 20) {
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
            Divider()
            
            DatePicker("Fecha de estreno",selection: $showDate, displayedComponents: .date)
                .padding(.vertical)
            
            Divider()
            
            HStack {
                Text("Puntuación:")
                Spacer()
                ForEach(1...5, id: \.self) { number in
                    Image(systemName: "star.fill")
                        .foregroundColor(number > score ? Color(.systemGray6) : .yellow)
                        .onTapGesture {
                            score = Int16(number)
                        }
                }
            }
            
            Divider()
            
            HStack {
                Text("Sinopsis:")
                    .font(.headline)
                Spacer()
            }
            TextEditor(text: $sinopsis)
                .colorMultiply(.white)
                .cornerRadius(10)
            
            Divider()
            
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
        }
        .padding()
        .navigationBarTitle(movie?.movieName ?? "", displayMode: .inline)
        .onAppear {
            if let updatedMovie = movie {
                movieName = updatedMovie.movieName
                showDate = updatedMovie.showDate
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
            movieViewModel.addMovie(movieName: movieName, showDate: showDate, sinopsis: sinopsis, score: score)
            dismiss()
        }
    }
    
    // MARK: Actualizar una película existente
    func updateMovie() {
//        if let updatedMovie = movie {
//            movies.updateMovie(movieId: updatedMovie.id, movieName: movieName, startDate: startDate, sinopsis: sinopsis, score: score)
//        }
        dismiss()
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        let movies = MovieCoreDataViewModel()
        MovieView(movieViewModel: movies, update: false)
    }
}
