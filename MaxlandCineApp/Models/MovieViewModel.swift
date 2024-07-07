//
//  MovieViewModel.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 9/3/22.
//

import Foundation
import SwiftData

@Observable 
class MovieViewModel {
    @ObservationIgnored let container = try! ModelContainer(for: MovieItem.self)
    @ObservationIgnored let biometricAuthUtil: BiometricAuth
    
    @MainActor
    var modelContext: ModelContext {
        container.mainContext
    }
    
    enum typeData {
        case All, Movies, Series
    }
    
    var movieList: [MovieItem] = []
    var biometricAuth: Bool = false {
        didSet {
            // MARK: Guardar en el UserDefaults el valor del parámetro de autenticación biométrica
            UserDefaults.standard.set(self.biometricAuth, forKey: "BiometricAuth")
        }
    }
    
    init() {
        biometricAuthUtil = BiometricAuth()
        biometricAuth = UserDefaults.standard.bool(forKey: "BiometricAuth")
    }
       
    @MainActor
    func fetchMovies() {
        let fetchDescriptor = FetchDescriptor<MovieItem>(predicate: nil, sortBy: [SortDescriptor<MovieItem>(\.showDate, order: .reverse)])
        
        do {
            movieList = try modelContext.fetch(fetchDescriptor)
        } catch let error {
            fatalError("Error recuperando datos: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func addMovie(movieName: String, showDate: Date, sinopsis: String, score: Int16, isSerie: Bool, caratula: Data?) {
        let newMovie = MovieItem(movieName: movieName, showDate: showDate, sinopsis: sinopsis, score: score, isSerie: isSerie, caratula: caratula)
        modelContext.insert(newMovie)
        saveData()
    }
    
    @MainActor
    func deleteMovie(movie: MovieItem) {
        modelContext.delete(movie)
        saveData()
    }
    
    @MainActor
    func updateMovie(movie: MovieItem, movieName: String, showDate: Date, sinopsis: String, score: Int16, isSerie: Bool, caratula: Data?) {
        movie.movieName = movieName
        movie.showDate = showDate
        movie.score = score
        movie.sinopsis = sinopsis
        movie.isSerie = isSerie
        movie.caratula = caratula
        saveData()
    }
       
    @MainActor
    func saveData() {
        do {
            try modelContext.save()
            fetchMovies()
        } catch let error {
            fatalError("Error actualizando datos: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func deleteAllMovies()
    {
        movieList.forEach {
            modelContext.delete($0)
        }
        
        saveData()
    }
    
    func getNumberMovies(type: typeData) -> Int {
        switch type {
            case .All: return movieList.count
            case .Movies: return movieList.filter( { !$0.isSerie } ).count
            case .Series: return movieList.filter( { $0.isSerie } ).count
        }
    }
    
    func getNumberMoviesByScore(type: typeData) -> [Int] {
        var moviesScore1 = 0
        var moviesScore2 = 0
        var moviesScore3 = 0
        var moviesScore4 = 0
        var moviesScore5 = 0
        
        switch type {
            case .All:
                moviesScore1 = movieList.filter( { $0.score == 1 } ).count
                moviesScore2 = movieList.filter( { $0.score == 2 } ).count
                moviesScore3 = movieList.filter( { $0.score == 3 } ).count
                moviesScore4 = movieList.filter( { $0.score == 4 } ).count
                moviesScore5 = movieList.filter( { $0.score == 5 } ).count
                break;
            case .Movies:
                moviesScore1 = movieList.filter( { $0.score == 1 && !$0.isSerie } ).count
                moviesScore2 = movieList.filter( { $0.score == 2 && !$0.isSerie } ).count
                moviesScore3 = movieList.filter( { $0.score == 3 && !$0.isSerie } ).count
                moviesScore4 = movieList.filter( { $0.score == 4 && !$0.isSerie } ).count
                moviesScore5 = movieList.filter( { $0.score == 5 && !$0.isSerie } ).count
                break;
            case .Series:
                moviesScore1 = movieList.filter( { $0.score == 1 && $0.isSerie } ).count
                moviesScore2 = movieList.filter( { $0.score == 2 && $0.isSerie } ).count
                moviesScore3 = movieList.filter( { $0.score == 3 && $0.isSerie } ).count
                moviesScore4 = movieList.filter( { $0.score == 4 && $0.isSerie } ).count
                moviesScore5 = movieList.filter( { $0.score == 5 && $0.isSerie } ).count
                break;
        }
        
        let movieListScore = [moviesScore1, moviesScore2, moviesScore3, moviesScore4, moviesScore5]
        
        return movieListScore
    }
    
    func getMoviesByScore(type: typeData, score: Int) -> [MovieItem] {
        switch type {
            case .All:
                return movieList.filter( { $0.score == score } )
            case .Movies:
                return movieList.filter( { $0.score == score && !$0.isSerie } )
            case .Series:
                return movieList.filter( { $0.score == score && $0.isSerie } )
        }
    }
    
    @MainActor
    func getJSONData() -> String? {
        var movieExportList: [MovieImportExportModel] = []
        var caratulaStr = ""
        
        movieList.forEach { movie in
            caratulaStr = ""
            
            if let caratula = movie.caratula {
                caratulaStr = caratula.base64EncodedString()
            }

            let movieExportModel = MovieImportExportModel(isSerie: movie.isSerie, movieName: movie.movieName, score: movie.score, showDate: movie.showDate, sinopsis: movie.sinopsis, caratula: caratulaStr)
            movieExportList.append(movieExportModel)
        }
        
        do {
            let jsonData = try JSONEncoder().encode(movieExportList)
            let jsonExportData = String(data: jsonData, encoding: String.Encoding.utf8)
            return(jsonExportData)
        } catch {
            fatalError("Error recuperando datos para exportar: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func setJSONData(moviesJSON: Result<URL, Error>) {
        do {
            guard let selectedFile: URL = try? moviesJSON.get() else { return }
            guard let jsonData = String(data: try Data(contentsOf: selectedFile), encoding: .utf8)?.data(using: .utf8) else { return }
            guard let movieImportModel = try? JSONDecoder().decode([MovieImportExportModel].self, from: jsonData) else { return }
            deleteAllMovies()
            var caratulaData: Data? = nil
            
            movieImportModel.forEach { movie in
                caratulaData = nil
                
                if let caratula = movie.caratula {
                    let base64EncodedData = caratula.data(using: .utf8)!

                    if let data = Data(base64Encoded: base64EncodedData) {
                        caratulaData = data
                    }
                }

                addMovie(movieName: movie.movieName!, showDate: movie.showDate!, sinopsis: movie.sinopsis!, score: movie.score, isSerie: movie.isSerie, caratula: caratulaData)
            }
            
        } catch {
            fatalError("Error en la importación de datos: \(error.localizedDescription)")
        }
    }
}
