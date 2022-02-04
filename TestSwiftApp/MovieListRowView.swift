//
//  MovieListRowView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 4/2/22.
//

import SwiftUI

struct MovieListRowView: View {
    let movie: MovieModel
    
    var body: some View {
        HStack {
            Image(systemName: "film").font(.title)
            VStack(alignment: .leading) {
                Text(movie.movieName).font(.caption).bold()
                Text(movie.startDate, style: .date).font(.caption2).foregroundColor(.gray)
            }
            .padding(.leading, 3)
            Spacer()
            HStack {
                ForEach(1...5, id: \.self) { number in
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundColor(number > movie.score ? Color(.systemGray6) : .yellow)
                        .padding(.trailing, -8)
                }
            }
            .padding(.trailing, 10)
        }
    }
}

struct MovieListRowView_Previews: PreviewProvider {
    static var previews: some View {
        let movie = MovieModel(movieName: "", startDate: Date(), sinopsis: "", score: 0)
        MovieListRowView(movie: movie)
    }
}
