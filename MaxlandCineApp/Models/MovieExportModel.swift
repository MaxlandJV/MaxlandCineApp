//
//  MovieExportModel.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 31/1/23.
//

import Foundation

struct MovieExportModel: Codable {
    public var isSerie: Bool
    public var movieName: String?
    public var score: Int16
    public var showDate: Date?
    public var sinopsis: String?
}
