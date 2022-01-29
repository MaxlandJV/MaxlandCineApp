//
//  FilmModelDAta.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import Foundation

struct Film: Hashable {
    var filmName: String
    var startDate: Date
    var sinopsis: String
    var boxOfficeReceipts: Double
}

final class Films {
    var filmsList: [Film] = []
}
