//
//  MovieListView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI

struct MovieTabView: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Image(systemName: "film")
                    Text("Películas")
                }
            MovieSetupView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Configuración")
                }
        }
        
    }
}

struct MovieTabView_Previews: PreviewProvider {
    static var previews: some View {
        MovieTabView()
    }
}
