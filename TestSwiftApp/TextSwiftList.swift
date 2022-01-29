//
//  TextSwiftList.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct TextSwiftList: View {
    
    @State var film: Film
    @State var films: Films
    
    var body: some View {
        VStack {
            Form {
                TextField("Nombre de la película", text: $film.filmName)
                DatePicker("Fecha de estreno",selection: $film.startDate)
                TextEditor(text: $film.sinopsis)
                TextField("Recaudación total", text: Binding(
                    get: { String(film.boxOfficeReceipts) },
                    set: { film.boxOfficeReceipts = Double($0) ?? 0 }
                ))
            }
            List {
                ForEach(films.filmsList, id: \.self) { filmItem in
                    Label(filmItem.filmName, systemImage: "film")
                }
            }
            Button {
                films.filmsList.append(film)
                print(film)
            } label: {
                Label("Guardar", systemImage: "doc.fill.badge.plus")
            }
        }
    }
}

struct TextSwiftList_Previews: PreviewProvider {
    static var previews: some View {
        let filmPreview: Film = Film(filmName: "Contact", startDate: Date.now, sinopsis: "Se detectan señales de una civilización extraterrestre desconocida", boxOfficeReceipts: 168_000_000)
        let filmsPreview: Films = Films()
        
        TextSwiftList(film: filmPreview, films: filmsPreview)
    }
}
