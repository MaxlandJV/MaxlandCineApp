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
                Image(systemName: isSerie! ? "sparkles.tv" : "film")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(isSerie! ? Color("Serie") : Color("Movie"))
            }
            else {
                Image(systemName: "film")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color("Movie"))
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(movieName ?? "")
                    .font(.headline).bold()
                HStack {
                    HStack(spacing: 0) {
                        ForEach(1...5, id: \.self) { number in
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(number > score ?? 0 ? Color("StarNoActive") : .yellow)
                        }
                    }
//                    Text("-")
//                        .font(.caption2)
//                        .foregroundColor(.black)
                    Spacer()
                    Text(showDate ?? Date(), style: .date)
                        .font(.caption).bold()
                        .foregroundColor(.black)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .background(.green)
        .cornerRadius(10)
    }
}

struct MovieListRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListRowView(movieName: "Prueba de película con nombre largo", showDate: Date(), sinopsis: "", score: 3, isSerie: false)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
