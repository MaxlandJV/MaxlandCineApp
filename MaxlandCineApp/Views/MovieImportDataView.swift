//
//  MovieImportDataView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 31/1/23.
//

import SwiftUI

struct MovieImportDataView: View {
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State private var pickFile: Bool = false
    @State private var fileURL: URL?
    
    var body: some View {
        VStack {
            Button {
                pickFile.toggle()
            } label: {
                Text("Importar")
            }
            .fileImporter(isPresented: $pickFile, allowedContentTypes: [.json]) { result in
                switch result {
                case .success(let success):
                    fileURL = success.absoluteURL
                    if let urlString = fileURL?.absoluteString {
                        let datos = movieViewModel.loadJson(fileName: urlString)
                        datos?.forEach({ data in
                            print(data.movieName!)
                        })
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            //.quickLookPreview($fileURL)
        }
        .navigationBarTitle("setup-exportar-datos")
    }
}

struct MovieImportDataView_Previews: PreviewProvider {
    static var previews: some View {
        MovieImportDataView()
    }
}
