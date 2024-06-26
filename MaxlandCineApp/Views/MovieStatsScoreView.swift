//
//  MovieStatsScoreView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 20/10/23.
//

import SwiftUI

struct MovieStatsScoreView: View {
    var selectedScoreMovieList: [MovieItem] = []
    
    var body: some View {
        HStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(selectedScoreMovieList) { movie in
                        VStack {
                            if let imageData = movie.caratula,
                               let selectedImage = UIImage(data: imageData) {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .frame(width: 96, height: 144)
                                    .cornerRadius(5)
                            }
                            else {
                                if (movie.isSerie) {
                                    Image(systemName: movie.isSerie ? "sparkles.tv" : "film")
                                        .resizable()
                                        .frame(width: 96, height: 144)
                                        .foregroundColor(movie.isSerie ? Color("Serie") : Color("Movie"))
                                        .padding(.vertical, 4)
                                        .padding(.leading, 4)
                                        .cornerRadius(5)
                                }
                                else {
                                    Image(systemName: "film")
                                        .resizable()
                                        .frame(width: 96, height: 144)
                                        .foregroundColor(Color("Movie"))
                                        .padding(.vertical, 4)
                                        .padding(.leading, 4)
                                        .cornerRadius(5)
                                }
                            }
                            
                            Text(movie.movieName ?? "")
                                .lineLimit(1)
                                .font(.footnote)
                        }
                        .frame(width: 100)
                    }
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(18)
    }
}

#Preview {
    MovieStatsScoreView()
}
