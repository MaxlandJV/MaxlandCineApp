//
//  TestSwiftAppApp.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

@main
struct MaxlandCineApp: App {
    
    @StateObject var movieViewModel = MovieViewModel()
    
    var body: some Scene {
        WindowGroup {
            //if movieViewModel.isAuthorized {
                MovieListView()
                    .environmentObject(movieViewModel)
            //}
        }
    }
}
