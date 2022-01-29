//
//  TestSwiftAppApp.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

@main
struct TestSwiftAppApp: App {
    let filmPreview: Film = Film(filmName: "Contact", startDate: Date.now, sinopsis: "Se detectan señales de una civilización extraterrestre desconocida", boxOfficeReceipts: 168_000_000)
    let filmsPreview: Films = Films()
    var body: some Scene {
        WindowGroup {
            TextSwiftList(film: filmPreview, films: filmsPreview)
        }
    }
}
