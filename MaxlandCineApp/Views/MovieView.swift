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
    @State var isSerie: Bool = false
    @State var movie: Movie?
    @State var showingAlert = false
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    // MARK: Este valor se pasa como parámetro. Si no se pasa el valor por defecto es FALSE
    var update: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            if !update {
                HStack {
                    Text("movie-new")
                        .padding(.vertical, 10)
                        .font(.title2)
                    Spacer()
                }
                TextField("movie-name", text: $movieName)
                    .focused($movieNameInfocus)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .disableAutocorrection(true)
                    .padding(.bottom, 10)
            }
            
            Divider()
            
            VStack {
                DatePicker("movie-date",selection: $showDate, displayedComponents: .date)
                    .padding(.top, 8)
                
                Divider()
                
                Toggle(isSerie ? "movie-type-1" : "movie-type-2", isOn: $isSerie)
                    .toggleStyle(CheckboxStyle())
                
                Divider()
            }
            
            HStack {
                Text("movie-score")
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
                Text("movie-review")
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
                        Label("movie-button-save", systemImage: "doc.fill.badge.plus")
                            .padding(.horizontal)
                    })
                        .buttonStyle(.borderedProminent)
                        .alert("movie-error-01", isPresented: $showingAlert) {}
                    
                    Button(action: { dismiss() }) {
                        Label("movie-button-cancel", systemImage: "xmark")
                            .padding(.horizontal)
                    }
                    .buttonStyle(.bordered)
                }
            }
            else {
                Button(action: updateMovie, label: {
                    Label("movie-button-update", systemImage: "doc.badge.gearshape.fill")
                        .padding(.horizontal)
                })
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .navigationBarTitle(movie?.movieName ?? "", displayMode: .inline)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: movieName + ": " + sinopsis)
            }
        })
        .onAppear {
            if let updatedMovie = movie {
                movieName = updatedMovie.movieName ?? ""
                showDate = updatedMovie.showDate ?? Date()
                sinopsis = updatedMovie.sinopsis ?? ""
                score = updatedMovie.score
                isSerie = updatedMovie.isSerie
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
            movieViewModel.addMovie(movieName: movieName, showDate: showDate, sinopsis: sinopsis, score: score, isSerie: isSerie)
            dismiss()
        }
    }
    
    // MARK: Actualizar una película existente
    func updateMovie() {
        if let updatedMovie = movie {
            movieViewModel.updateMovie(movie: updatedMovie, movieName: movieName, showDate: showDate, sinopsis: sinopsis, score: score, isSerie: isSerie)
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
