//
//  MovieCoreDataViewModel.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 9/3/22.
//

import CoreData

class MovieCoreDataViewModel: ObservableObject {
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
    
    func deleteMovie(indexSet: IndexSet) {
        
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
