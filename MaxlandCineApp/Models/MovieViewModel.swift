//
//  MovieViewModel.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 9/3/22.
//

import CoreData

@Observable class MovieViewModel {
    @ObservationIgnored let dataModel: NSPersistentContainer
    @ObservationIgnored let biometricAuthUtil: BiometricAuth
    
    enum typeData {
        case All, Movies, Series
    }
    
    var movieList: [Movie] = []
    var biometricAuth: Bool = false {
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
    
    func addMovie(movieName: String, showDate: Date, sinopsis: String, score: Int16, isSerie: Bool, caratula: Data?) {
        let newMovie = Movie(context: dataModel.viewContext)
        newMovie.movieName = movieName
        newMovie.showDate = showDate
        newMovie.score = score
        newMovie.sinopsis = sinopsis
        newMovie.isSerie = isSerie
        newMovie.caratula = caratula
        saveData()
    }
    
    func deleteMovie(movie: Movie) {
        dataModel.viewContext.delete(movie)
        saveData()
    }
    
    func updateMovie(movie: Movie, movieName: String, showDate: Date, sinopsis: String, score: Int16, isSerie: Bool, caratula: Data?) {
        movie.movieName = movieName
        movie.showDate = showDate
        movie.score = score
        movie.sinopsis = sinopsis
        movie.isSerie = isSerie
        movie.caratula = caratula
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
    
    func deleteAllMovies()
    {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Movie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try dataModel.viewContext.execute(deleteRequest)
            fetchMovies()
        } catch let error {
            fatalError("Error eliminando todos los datos: \(error.localizedDescription)")
        }
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
    
    func getMoviesByScore(type: typeData, score: Int) -> [Movie] {
        switch type {
            case .All:
                return movieList.filter( { $0.score == score } )
            case .Movies:
                return movieList.filter( { $0.score == score && !$0.isSerie } )
            case .Series:
                return movieList.filter( { $0.score == score && $0.isSerie } )
        }
    }
    
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
