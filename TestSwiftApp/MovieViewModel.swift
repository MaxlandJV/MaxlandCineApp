//
//  MovieViewModel.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 30/1/22.
//

import Foundation
import SwiftUI

final class MoviesViewModel: ObservableObject {
    @Published var movieList: [MovieModel] = []
    
    init() {
        movieList = getAllMovies()
    }
    
    func saveMovie(movieName: String, startDate: Date, sinopsis: String, score: Int) {
        let movie = MovieModel(movieName: movieName, startDate: startDate, sinopsis: sinopsis, score: score)
        
        movieList.insert(movie, at: 0)
        //movieList.append(movie)
        encodeAndSaveAllMovies()
    }
    
    private func encodeAndSaveAllMovies() {
        if let encoded = try? JSONEncoder().encode(movieList) {
            UserDefaults.standard.set(encoded, forKey: "movies")
        }
    }
    
    func getAllMovies() -> [MovieModel] {
        if let moviesData = UserDefaults.standard.object(forKey: "movies") as? Data {
            if let movies = try? JSONDecoder().decode([MovieModel].self, from: moviesData) {
                return movies
            }
        }
        return []
    }
    
    func deleteMovie(id: String) {
        movieList.removeAll { movie in
            movie.id == id
        }
        encodeAndSaveAllMovies()
    }
    
    func updateMovie(movieId: String, movieName: String, startDate: Date, sinopsis: String, score: Int) {
        if let index = movieList.firstIndex(where: { $0.id == movieId }) {
            movieList[index].movieName = movieName
            movieList[index].startDate = startDate
            movieList[index].sinopsis = sinopsis
            movieList[index].score = score
            encodeAndSaveAllMovies()
        }        
    }
}
