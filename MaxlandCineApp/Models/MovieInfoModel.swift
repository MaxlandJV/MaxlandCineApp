//
//  MovieInfoModel.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 20/10/23.
//

import Foundation

struct Info: Identifiable {
    let id: String = UUID().uuidString
    let starsNumber: Int
    let movies: Int
}
