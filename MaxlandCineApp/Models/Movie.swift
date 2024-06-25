//
//  Movie.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 25/6/24.
//
//

import Foundation
import SwiftData


@Model public class Movie {
    var caratula: Data?
    var isSerie: Bool?
    var movieName: String
    var score: Int16? = 0
    var showDate: Date?
    var sinopsis: String?
    public init(movieName: String) {
        self.movieName = movieName

    }
    
}
