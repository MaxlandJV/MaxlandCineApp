//
//  MovieStatsGraphBarView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 29/5/22.
//

import SwiftUI

struct MovieStatsGraphBarView: View {
    
    let starsNumber: Int
    let movies: Int
    let score: CGFloat
    
    var body: some View {
        VStack {
            Text("\(movies)")
                .font(.headline)
            Capsule()
                .fill(Color.blue.opacity(0.5 + CGFloat(Double(starsNumber) / 10.0)))
                .frame(width: 18, height: score)
            HStack(spacing: 0) {
                Text("\(starsNumber)")
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
            }
            .font(.subheadline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

struct MovieStatsGraphBarView_Previews: PreviewProvider {
    static var previews: some View {
        MovieStatsGraphBarView(starsNumber: 3, movies: 5, score: 56.78)
    }
}
