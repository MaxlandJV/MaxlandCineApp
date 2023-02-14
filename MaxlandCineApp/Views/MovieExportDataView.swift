//
//  MovieExportDataView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 16/12/22.
//

import SwiftUI

struct MovieExportDataView: View {
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State private var exportFile: Bool = false
    
    var body: some View {
        VStack {
            Text("Mediante esta opción se pueden exportar todos los datos contenidos en la aplicación a un archivo de texto en formato JSON")
                .font(.headline)
            Image(systemName: "doc.text")
                .resizable()
                .frame(width: 150, height: 190)
                .padding(.top, 100)
            Button {
                exportFile.toggle()
            } label: {
                Text("movie-export-Data")
            }
            .padding(.top, 20)
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .fileExporter(isPresented: $exportFile, document: JsonFile(json: movieViewModel.getJSONData() ?? ""), contentType: .json, defaultFilename: "mxlcdata") { result in
                switch result {
                case .success(_):
                    print("Exportado correctamente")
                case .failure(let failure):
                    fatalError(failure.localizedDescription)
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("setup-exportar-datos")
    }
}

struct MovieExportDataView_Previews: PreviewProvider {
    static var previews: some View {
        MovieExportDataView()
            .environmentObject(MovieViewModel())
    }
}
