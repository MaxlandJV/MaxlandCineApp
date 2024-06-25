//
//  MovieView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI
import PhotosUI

struct MovieView: View {
    @Environment(\.dismiss) var dismiss
    
    @FocusState var movieNameInfocus: Bool
    
    @State var movieName = ""
    @State var showDate = Date()
    @State var sinopsis = ""
    @State var score: Int16 = 0
    @State var isSerie: Bool = false
    @State var movie: Movie?
    @State var showingAlert = false
    @State var showingPhotos = false
    @State private var showingConfirmation = false
    @State private var menuOption = 0
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    @State private var photoDataCompressed: Data?
    @State private var selectedImage: UIImage?
    @State private var showImage: Bool = false
    
    @Environment(MovieViewModel.self) var movieViewModel
    
    // MARK: Este valor se pasa como parámetro. Si no se pasa el valor por defecto es FALSE
    var update: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                if update {
                    if let selectedImage {
                        VStack {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .padding(.vertical)
                                .overlay {
                                    LinearGradient(colors: [Color("Degradado"), Color("Degradado"), Color("Degradado"), Color("Degradado").opacity(0.9), Color("Degradado").opacity(0.5), Color("Degradado").opacity(0.1), .clear, .clear, .clear, Color("Degradado").opacity(0.1), Color("Degradado").opacity(0.5), Color("Degradado").opacity(0.9), Color("Degradado"), Color("Degradado")], startPoint: .top, endPoint: .bottom)
                                }
                                .onTapGesture {
                                    showImage.toggle()
                                }
                        }
                        .frame(height: getSizeScreen())
                    }
                }
                VStack {
                    if !update {
                        TextField("movie-name", text: $movieName)
                            .focused($movieNameInfocus)
                            .padding()
                            .cornerRadius(10)
                            .disableAutocorrection(true)
                            .padding(.bottom, 10)
                    }
                    
                    Divider()
                    
                    VStack {
                        DatePicker("movie-date",selection: $showDate, displayedComponents: .date)
                            .padding(.top, 8)
                        
                        Divider()
                        
                        Toggle(isSerie ? "movie-type-1" : "movie-type-2", isOn: $isSerie)
                            .toggleStyle(CheckboxStyle())
                        
                        Divider()
                    }
                    
                    HStack {
                        Text("movie-score")
                        Spacer()
                        ForEach(1...5, id: \.self) { number in
                            Image(systemName: "star.fill")
                                .foregroundColor(number > score ? Color("StarNoActive") : .orange)
                                .onTapGesture {
                                    score = Int16(number)
                                }
                        }
                    }
                    .padding(.vertical, 10)
                    
                    Divider()
                    
                    if !update {
                        PhotosPicker(selection: $selectedItem, matching: .images) {
                            Text("movie-upload-photo")
                        }
                        .padding()
                        
                        if let selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .padding(.vertical)
                        }
                        
                        Divider()
                    }
                    
                    HStack {
                        Text("movie-review")
                            .font(.headline)
                            .padding(.top, 10)
                        Spacer()
                    }
                    
                    TextField("", text: $sinopsis, axis: .vertical)
//                    TextEditor(text: $sinopsis)
//                        .cornerRadius(10)
//                        .scrollContentBackground(.hidden)
//                        .background(.clear)
//                        .frame(height: 300)
                }
                .padding()
            }
            .navigationBarTitle(movie?.movieName ?? NSLocalizedString("movie-new", comment: ""), displayMode: .inline)
            .toolbar {
                if update {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: updateMovie, label: {
                            Text("movie-button-update")
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button {
                                showingPhotos.toggle()
                            } label: {
                                Label("movie-upload-photo", systemImage: "photo")
                            }
                            
                            ShareLink(item: movieName + ": " + sinopsis)
                            
                            Button {
                                showingConfirmation.toggle()
                            } label: {
                                Label("movie-confirm-delete", systemImage: "trash")
                            }
                        }
                    label: {
                        Image(systemName: "ellipsis.circle")
                    }
                    .confirmationDialog("", isPresented: $showingConfirmation) {
                        Button("movie-confirm-delete", role: .destructive) {
                            movieViewModel.deleteMovie(movie: movie!)
                            dismiss()
                        }
                        Button("movie-button-cancel", role: .cancel) { }
                    }
                    .photosPicker(isPresented: $showingPhotos, selection: $selectedItem, matching: .images)
                    }
                }
                else {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("movie-button-cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: newMovie, label: {
                            Text("movie-button-save")
                        })
                        .alert("movie-error-01", isPresented: $showingAlert) {}
                    }
                }
            }
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        selectedPhotoData = data
                        if let selectedPhotoData, let image = UIImage(data: selectedPhotoData) {
                            selectedImage = ImageManagement.resizeImage(image: image, targetSize: CGSize(width: 1024, height: 768))
                            if let image = selectedImage {
                                photoDataCompressed = image.jpegData(compressionQuality: 0.8)
                            }
                        }
                    }
                }
            }
            .onAppear {
                if let updatedMovie = movie {
                    movieName = updatedMovie.movieName ?? ""
                    showDate = updatedMovie.showDate ?? Date()
                    sinopsis = updatedMovie.sinopsis ?? ""
                    score = updatedMovie.score
                    isSerie = updatedMovie.isSerie
                    if let imageData = updatedMovie.caratula {
                        selectedImage = UIImage(data: imageData)
                        photoDataCompressed = imageData
                    }
                } else {
                    // Poner el foco en el campo del nombre de la película
                    // Si se cambia el valor de "movieNameInFocus" no funciona
                    // Hay que hacerlo desde algún disparador como un botón
                    // o en este caso desde un evento asíncrono
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        movieNameInfocus = true
                    }
                }
            }
        }
        .sheet(isPresented: $showImage) {
            if update {
                if let selectedImage {
                    VStack {
                        GeometryReader { geometry in
                            let size = geometry.size
                            
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                        }
                        .overlay(alignment: .top) {
                            HStack {
                                Spacer()
                                
                                Button {
                                    showImage.toggle()
                                } label: {
                                    Image(systemName: "xmark")
                                        .font(.title3)
                                        .padding(10)
                                        .background(.black)
                                        .cornerRadius(50)
                                }
                                .padding([.trailing, .top], 20)
                            }
                        }
                    }
                    .ignoresSafeArea()
                }
            }
        }
    }
    
    // Crear nueva película
    @MainActor 
    func newMovie() {
        if (movieName.isEmpty) {
            showingAlert = true
        } else {
            movieViewModel.addMovie(movieName: movieName, showDate: showDate, sinopsis: sinopsis, score: score, isSerie: isSerie, caratula: photoDataCompressed)
            dismiss()
        }
    }
    
    // Actualizar una película existente
    @MainActor 
    func updateMovie() {
        if let updatedMovie = movie {
            movieViewModel.updateMovie(movie: updatedMovie, movieName: movieName, showDate: showDate, sinopsis: sinopsis, score: score, isSerie: isSerie, caratula: photoDataCompressed)
        }
        dismiss()
    }
    
    // Obtener el tamaño según el dispositivo
    func getSizeScreen() -> CGFloat {
        var sizeScreen:CGFloat = 280
        
        if UIDevice().userInterfaceIdiom == .pad {
            sizeScreen = 800
        }
        
        return sizeScreen
    }
}

#Preview {
    NavigationStack {
        MovieView(update: true)
    }
}
