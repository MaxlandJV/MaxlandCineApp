//
//  ContentView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var films = Films()
    
    var body: some View {
        NavigationView {
            List(films.filmsList) { filmItem in
                HStack {
                    Image(systemName: "film").font(.title)
                    VStack(alignment: .leading) {
                        Text(filmItem.filmName).font(.caption).bold()
                        HStack {
                            Text(filmItem.startDate, style: .date).font(.caption2).foregroundColor(.gray)
                            Spacer()
                            ForEach(1...5, id: \.self) { number in
                                Image(systemName: "star.fill")
                                    .font(.caption2)
                                    .foregroundColor(number > filmItem.score ? Color(.systemGray6) : .yellow)
                                    .padding(.trailing, -8)
                            }
                        }
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
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Text("Añadir película")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
