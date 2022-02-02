//
//  TextSwiftList.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct TextSwiftList: View {
    @Environment(\.dismiss) var dismiss
    @State var filmName = ""
    @State var startDate = Date()
    @State var sinopsis = ""
    @State var score = 0
    @State var film: Film
    @StateObject var films: Films
    var update: Bool
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Película")) {
                    TextField("Nombre de la película", text: $filmName)
                    DatePicker("Fecha de estreno",selection: $startDate, displayedComponents: .date)
                    Stepper("Puntuación: \(score)", value: $score, in: 0...5)
                }
                Section(header: Text("Sinopsis")) {
                    TextEditor(text: $sinopsis)
                        .frame(height: 100)
                }
            }
            if !update {
                Button {
                    films.saveFilm(filmName: filmName, startDate: startDate, sinopsis: sinopsis, score: score)
                    dismiss()
                } label: {
                    Label("Guardar", systemImage: "doc.fill.badge.plus")
                        .padding()
                }.buttonStyle(.bordered)
            }
            else {
                Button {
                    films.updateFilm(film: $film, filmName: filmName, startDate: startDate, sinopsis: sinopsis, score: score)
                    dismiss()
                } label: {
                    Label("Actualizar", systemImage: "doc.fill.badge.plus")
                        .padding()
                }.buttonStyle(.bordered)
            }
        }
        .onAppear{
            filmName = film.filmName
            startDate = film.startDate
            sinopsis = film.sinopsis
            score = film.score
        }
    }
}

struct TextSwiftList_Previews: PreviewProvider {
    static var previews: some View {
        let films = Films()
        let film = Film(filmName: "", startDate: Date(), sinopsis: "", score: 0)
        TextSwiftList(film: film, films: films, update: false)
    }
}
