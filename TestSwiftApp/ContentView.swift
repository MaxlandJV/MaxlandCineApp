//
//  ContentView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var films = Films()
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List(films.filmsList) { filmItem in
                NavigationLink(destination: TextSwiftList(film: filmItem, films: films, update: true)) {
                    HStack {
                        Image(systemName: "film").font(.title)
                        VStack(alignment: .leading) {
                            Text(filmItem.filmName).font(.caption).bold()
                            Text(filmItem.startDate, style: .date).font(.caption2).foregroundColor(.gray)
                        }
                        .padding(.leading, 3)
                        Spacer()
                        HStack {
                            ForEach(1...5, id: \.self) { number in
                                Image(systemName: "star.fill")
                                    .font(.caption2)
                                    .foregroundColor(number > filmItem.score ? Color(.systemGray6) : .yellow)
                                    .padding(.trailing, -8)
                            }
                        }
                        .padding(.trailing, 10)
                    }
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
            .listStyle(PlainListStyle())
            .navigationTitle(Text("Películas"))
            .navigationBarItems(trailing: Button {
                isPresented = true
            } label: {
                Text("Añadir película")
            })
            .sheet(isPresented: $isPresented, onDismiss: {
                isPresented = false
            }, content: {
                let film = Film(filmName: "", startDate: Date(), sinopsis: "", score: 0)
                TextSwiftList(film: film, films: films, update: false)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
