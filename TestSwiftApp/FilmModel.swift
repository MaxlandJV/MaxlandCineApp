//
//  FilmModel.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 30/1/22.
//

import Foundation

struct Film: Codable, Identifiable {
    let id: String
    var filmName: String
    var startDate: Date
    var sinopsis: String
    var score: Int
    
    init(filmName: String, startDate: Date = Date(), sinopsis: String = "", score: Int = 0) {
        self.id = UUID().uuidString
        self.filmName = filmName
        self.startDate = startDate
        self.sinopsis = sinopsis
        self.score = score
    }
}
