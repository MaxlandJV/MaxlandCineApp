//
//  TextSwiftList.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct TextSwiftList: View {
    
    @State var filmName = ""
    @State var startDate = Date.now
    @State var sinopsis = ""
    @State var score = 0
    @StateObject var films = Films()
    
    var body: some View {
        VStack {
            Form {
                TextField("Nombre de la película", text: $filmName)
                DatePicker("Fecha de estreno",selection: $startDate, displayedComponents: .date)
                TextEditor(text: $sinopsis)
                TextField("Puntuación", text: Binding(
                    get: { score == 0 ? "" : String(score) },
                    set: { score = Int($0) ?? 0 }
                ))
            }
            .frame(height: 250)
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
            List(films.filmsList, id: \.id) { filmItem in
                HStack {
                    Image(systemName: "film").font(.title)
                    VStack(alignment: .leading) {
                        Text(filmItem.filmName).fontWeight(.bold)
                        Text(filmItem.startDate, style: .date).font(.subheadline)
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
