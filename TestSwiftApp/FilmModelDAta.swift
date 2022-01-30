//
//  FilmModelData.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import Foundation

// MARK: Model
struct Film: Hashable, Codable {
    let filmName: String
    let startDate: Date
    let sinopsis: String
    let score: Int
}

// MARK: ViewModel
final class Films: ObservableObject {
    @Published var filmsList: [Film] = []
    
    init() {
        filmsList = getAllFilms()
    }
    
    func saveFilm(filmName: String, startDate: Date, sinopsis: String, score: Int) {
        let film = Film(filmName: filmName, startDate: startDate, sinopsis: sinopsis, score: score)
        
        filmsList.insert(film, at: 0)
        
        encodeAndSaveAllFilms()
    }
    
    private func encodeAndSaveAllFilms() {
        if let encoded = try? JSONEncoder().encode(filmsList) {
            UserDefaults.standard.set(encoded, forKey: "films")
        }
    }
    
    func getAllFilms() -> [Film] {
        if let filmsData = UserDefaults.standard.object(forKey: "films") as? Data {
            if let films = try? JSONDecoder().decode([Film].self, from: filmsData) {
                return films
            }
        }
        return []
    }
}
