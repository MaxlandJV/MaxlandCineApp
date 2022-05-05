//
//  MovieView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct MovieView: View {
    @Environment(\.dismiss) var dismiss
    
    @FocusState var movieNameInfocus: Bool
    
    @State var movieName = ""
    @State var showDate = Date()
    @State var sinopsis = ""
    @State var score: Int16 = 0
    @State var movie: Movie?
    @State var showingAlert = false
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    // MARK: Este valor se pasa como parámetro. Si no se pasa el valor por defecto es FALSE
    var update: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
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
                    .padding(.bottom, 10)
            }
            Divider()
            
            DatePicker("Fecha de visionado",selection: $showDate, displayedComponents: .date)
                .padding(.vertical)
            
            Divider()
            
            HStack {
                Text("Puntuación:")
                Spacer()
                ForEach(1...5, id: \.self) { number in
                    Image(systemName: "star.fill")
                        .foregroundColor(number > score ? Color("StarNoActive") : .orange)
                        .onTapGesture {
                            score = Int16(number)
                        }
                }
            }.padding(.vertical, 10)
            
            Divider()
            
            HStack {
                Text("Opinión:")
                    .font(.headline)
                    .padding(.top, 10)
                Spacer()
            }
            TextEditor(text: $sinopsis)
                .colorMultiply(.white)
                .cornerRadius(10)
            
            Divider()
                .padding(.bottom, 10)
            
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
                movieName = updatedMovie.movieName ?? ""
                showDate = updatedMovie.showDate ?? Date()
                sinopsis = updatedMovie.sinopsis ?? ""
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
        if let updatedMovie = movie {
            movieViewModel.updateMovie(movie: updatedMovie, movieName: movieName, showDate: showDate, sinopsis: sinopsis, score: score)
        }
        dismiss()
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieView()
        }
    }
}
