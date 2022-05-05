//
//  MovieEmptyView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 1/4/22.
//

import SwiftUI

struct MovieEmptyView: View {
    var body: some View {
               VStack(spacing: 20) {
                Spacer()
                Text("Todavía no han creeado películas")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Añada su primera película para poder valorarla y realizar la crítica correspondiente.")
                    .padding(.bottom, 30)
                   NavigationLink {
                       MovieView()
                   } label: {
                       Label {
                           Text("Añadir primera película")
                       } icon: {
                          Image(systemName: "plus.circle")
                       }
                       .font(.headline)
                   }
                   .buttonStyle(.borderedProminent)
                   .tint(.orange)
                Spacer()
                Spacer()
                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(40)
    }
}

struct MovieEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        MovieEmptyView()
    }
}
