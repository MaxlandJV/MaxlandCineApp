//
//  TestSwiftAppApp.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

@main
struct TestSwiftAppApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MovieListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
