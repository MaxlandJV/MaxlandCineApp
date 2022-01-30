//
//  TextSwiftList.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct TextSwiftList: View {
    
    @State var filmName = ""
    @State var startDate = Date()
    @State var sinopsis = ""
    @State var score = 0
    @StateObject var films = Films()
    
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
                }
            }
            Button {
                films.saveFilm(filmName: filmName, startDate: startDate, sinopsis: sinopsis, score: score)
                filmName = ""
                startDate = Date.now
                sinopsis = ""
                score = 0
            } label: {
                Label("Guardar", systemImage: "doc.fill.badge.plus")
                    .padding()
            }.buttonStyle(.bordered)
            List(films.filmsList) { filmItem in
                HStack {
                    Image(systemName: "film").font(.title)
                    VStack(alignment: .leading) {
                        Text(filmItem.filmName).font(.caption).bold()
                        Text(filmItem.startDate, style: .date).font(.caption2).foregroundColor(.gray)
                    }
                    Spacer()
                    Text(String(filmItem.score))
                }
                .swipeActions(edge: .leading) {
                    Button {
                        films.deleteFilm(id: filmItem.id)
                    } label: {
                        Label("Eliminar", systemImage: "trash.fill")
                    }
                    .tint(.red)

                }
            }
        }
    }
}

struct TextSwiftList_Previews: PreviewProvider {
    static var previews: some View {
        TextSwiftList()
    }
}
