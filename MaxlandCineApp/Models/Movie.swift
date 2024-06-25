//
//  Movie.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 25/6/24.
//
//

import Foundation
import SwiftData

@Model
class Movie {
    var caratula: Data?
    var isSerie: Bool
    var movieName: String
    var score: Int16 = 0
    var showDate: Date
    var sinopsis: String
    
    init(movieName: String, showDate: Date, sinopsis: String, score: Int16, isSerie: Bool, caratula: Data?) {
        self.movieName = movieName
        self.showDate = showDate
        self.sinopsis = sinopsis
        self.score = score
        self.isSerie = isSerie
        self.caratula = caratula
    }
}
