//
//  MovieListRowView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 4/2/22.
//

import SwiftUI

struct MovieListRowView: View {
    let movie: FetchedResults<Movie>.Element
    
    var body: some View {
        HStack {
            Image(systemName: "film").font(.title)
            VStack(alignment: .leading) {
                Text(movie.movieName ?? "").font(.subheadline).bold()
                HStack {
                    HStack(spacing: 0) {
                        ForEach(1...5, id: \.self) { number in
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundColor(number > movie.score ? Color(.systemGray6) : .yellow)
                        }
                    }
                    Text("-")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text(movie.showDate ?? Date(), style: .date)
                        .font(.caption2)
                        .foregroundColor(Color.black)
                }
            }
        }
    }
}

//struct MovieListRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieListRowView(movie: MovieModel(movieName: "Nombre de la película bastante largo para que quepa", startDate: Date(), sinopsis: "", score: 5))
//    }
//}
