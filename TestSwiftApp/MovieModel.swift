//
//  MovieModel.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 30/1/22.
//

import Foundation

struct MovieModel: Codable, Identifiable {
    let id: String
    var movieName: String
    var startDate: Date
    var sinopsis: String
    var score: Int
    
    init(movieName: String, startDate: Date = Date(), sinopsis: String = "", score: Int = 0) {
        self.id = UUID().uuidString
        self.movieName = movieName
        self.startDate = startDate
        self.sinopsis = sinopsis
        self.score = score
    }
}
