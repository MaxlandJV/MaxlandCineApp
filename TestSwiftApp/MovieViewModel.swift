//
//  MovieViewModel.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 9/3/22.
//

import CoreData

class MovieViewModel: ObservableObject {
    let dataModel: NSPersistentContainer
    
    @Published var movieList: [Movie] = []
    
    init() {
        dataModel = NSPersistentContainer(name: "MovieDataModel")
        dataModel.loadPersistentStores { description, error in
            if let error = error {
                print("Error cargando CoreData: \(error)")
            }
        }
        fetchMovies()
    }
    
    func fetchMovies() {
        let request = NSFetchRequest<Movie>(entityName: "Movie")
        
        do {
            movieList = try dataModel.viewContext.fetch(request)
        } catch let error {
            print("Error recuperando datos: \(error)")
        }
    }
    
    func addMovie(movieName: String, showDate: Date, sinopsis: String, score: Int16) {
        let newMovie = Movie(context: dataModel.viewContext)
        newMovie.movieName = movieName
        newMovie.showDate = showDate
        newMovie.score = score
        newMovie.sinopsis = sinopsis
        saveData()
    }
    
    func deleteMovie(movie: Movie) {
        dataModel.viewContext.delete(movie)
        saveData()
    }
    
    func updateMovie(movie: Movie, movieName: String, showDate: Date, sinopsis: String, score: Int16) {
        movie.movieName = movieName
        movie.showDate = showDate
        movie.score = score
        movie.sinopsis = sinopsis
        saveData()
    }
       
    func saveData() {
        do {
            try dataModel.viewContext.save()
            fetchMovies()
        } catch let error {
            print("Error actualizando datos: \(error)")
        }
    }
}