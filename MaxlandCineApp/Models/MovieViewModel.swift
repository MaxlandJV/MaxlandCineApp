//
//  MovieViewModel.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 9/3/22.
//

import CoreData

class MovieViewModel: ObservableObject {
    let dataModel: NSPersistentContainer
    let biometricAuthUtil: BiometricAuth
    
    enum typeData {
        case All, Movies, Series
    }
    
    @Published var movieList: [Movie] = []
    @Published var biometricAuth: Bool = false {
        didSet {
            // MARK: Guardar en el UserDefaults el valor del parámetro de autenticación biométrica
            UserDefaults.standard.set(self.biometricAuth, forKey: "BiometricAuth")
        }
    }
    
    init() {
        biometricAuthUtil = BiometricAuth()
        biometricAuth = UserDefaults.standard.bool(forKey: "BiometricAuth")
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
    
    func addMovie(movieName: String, showDate: Date, sinopsis: String, score: Int16, isSerie: Bool) {
        let newMovie = Movie(context: dataModel.viewContext)
        newMovie.movieName = movieName
        newMovie.showDate = showDate
        newMovie.score = score
        newMovie.sinopsis = sinopsis
        newMovie.isSerie = isSerie
        saveData()
    }
    
    func deleteMovie(movie: Movie) {
        dataModel.viewContext.delete(movie)
        saveData()
    }
    
    func updateMovie(movie: Movie, movieName: String, showDate: Date, sinopsis: String, score: Int16, isSerie: Bool) {
        movie.movieName = movieName
        movie.showDate = showDate
        movie.score = score
        movie.sinopsis = sinopsis
        movie.isSerie = isSerie
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
    
    func getNumberMovies(type: typeData) -> Int {
        switch type {
        case .All: return movieList.count
        case .Movies: return movieList.filter( { !$0.isSerie } ).count
        case .Series: return movieList.filter( { $0.isSerie } ).count
        }
    }
    
    func getNumberMoviesByScore() -> [Int] {
        let moviesScore1 = movieList.filter( { $0.score == 1 } ).count
        let moviesScore2 = movieList.filter( { $0.score == 2 } ).count
        let moviesScore3 = movieList.filter( { $0.score == 3 } ).count
        let moviesScore4 = movieList.filter( { $0.score == 4 } ).count
        let moviesScore5 = movieList.filter( { $0.score == 5 } ).count
        
        let movieListScore = [moviesScore1, moviesScore2, moviesScore3, moviesScore4, moviesScore5]
        
        return movieListScore
    }
}
