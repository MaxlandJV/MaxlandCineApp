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
            Button {
                exportFile.toggle()
            } label: {
                Text("Exportar")
            }
            .fileExporter(isPresented: $exportFile, document: JsonFile(json: movieViewModel.getJSONData() ?? ""), contentType: .json, defaultFilename: "jsondata") { result in
                switch result {
                case .success(_):
                    print("Exportado correctamente")
                case .failure(let failure):
                    fatalError(failure.localizedDescription)
                }
           }
        }
        .navigationBarTitle("setup-exportar-datos")
    }
}

struct MovieExportDataView_Previews: PreviewProvider {
    static var previews: some View {
        MovieExportDataView()
    }
}
