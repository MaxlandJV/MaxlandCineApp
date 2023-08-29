//
//  MovieEmptyView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 1/4/22.
//

import SwiftUI

struct MovieEmptyView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("empty-title")
                .font(.title2)
                .fontWeight(.bold)
            Text("empty-add-movie-text")
                .padding(.bottom, 30)
            Button {
                isPresented.toggle()
            } label: {
                Label {
                    Text("empty-add-movie-button")
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
    @State static var isPresented: Bool = false
    static var previews: some View {
        MovieEmptyView(isPresented: $isPresented)
    }
}
