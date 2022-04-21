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
    @Published var biometricAuth: Bool = false
    
    init() {
        dataModel = NSPersistentContainer(name: "MovieDataModel")
        dataModel.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error cargando CoreData: \(error.localizedDescription)")
            }
        }
        fetchMovies()
    }
    
    func fetchMovies() {
        let request = NSFetchRequest<Movie>(entityName: "Movie")
        let sort = NSSortDescriptor(keyPath: \Movie.showDate, ascending: false)
        
        request.sortDescriptors = [sort]
        
        do {
            movieList = try dataModel.viewContext.fetch(request)
        } catch let error {
            fatalError("Error recuperando datos: \(error.localizedDescription)")
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
            fatalError("Error actualizando datos: \(error.localizedDescription)")
        }
    }
}
