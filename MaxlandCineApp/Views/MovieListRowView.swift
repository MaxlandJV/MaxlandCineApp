//
//  MovieListRowView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 4/2/22.
//

import SwiftUI

struct MovieListRowView: View {
    let movieName: String?
    let showDate: Date?
    let sinopsis: String?
    let score: Int16?
    let isSerie: Bool?
    
    var body: some View {
        HStack {
            if (isSerie != nil) {
                Image(systemName: isSerie! ? "sparkles.tv" : "film").font(.title)
            }
            else {
                Image(systemName: "film").font(.title)
            }
            VStack(alignment: .leading) {
                Text(movieName ?? "").font(.subheadline).bold()
                HStack {
                    HStack(spacing: 0) {
                        ForEach(1...5, id: \.self) { number in
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(number > score ?? 0 ? Color("StarNoActive") : .yellow)
                        }
                    }
                    Text("-")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text(showDate ?? Date(), style: .date)
                        .font(.caption2)
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}

struct MovieListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListRowView(movieName: "Prueba de película con nombre largo", showDate: Date(), sinopsis: "", score: 3, isSerie: false)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
