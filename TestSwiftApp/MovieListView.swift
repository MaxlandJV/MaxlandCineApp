//
//  MovieListView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI
import CoreData

struct MovieListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Movie.showDate, ascending: false)],
//        animation: .default)
//    private var items: FetchedResults<Movie>
    
    @FetchRequest(entity: Movie.entity(), sortDescriptors: []) var xMovies: FetchedResults<Movie>
   
    @StateObject var movies = MoviesViewModel()
    @State var isPresented: Bool = false
       
    var body: some View {
        NavigationView {
            LinearGradient(colors: [Color(#colorLiteral(red: 0.4905710816, green: 0.8656919599, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .overlay(
                    List(xMovies) { movieItem in
//                            NavigationLink(destination: MovieView(movie: movieItem, movies: movies, update: true)) {
                            MovieListRowView(movie: movieItem)
//                        }
//                        .swipeActions(edge: .leading) {
//                            Button {
//                                movies.deleteMovie(id: movieItem.id)
//                            } label: {
//                                Label("Eliminar", systemImage: "trash.fill")
//                            }
//                            .tint(.red)
//                        }
//                        .listRowBackground(Color.white.opacity(0))
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle(Text("Películas"))
                    .navigationBarItems(trailing: Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    })
                    .sheet(isPresented: $isPresented) {
                        MovieView(movies: movies, update: false)
                    }
                )
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
