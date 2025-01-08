//
//  MovieExportDataView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 16/12/22.
//

import SwiftUI

struct MovieExportDataView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(MovieViewModel.self) var movieViewModel: MovieViewModel
    @State private var exportFile: Bool = false
    @State var showingAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("movie-export-detail")
                    .font(.headline)
                Image(systemName: "arrow.down.doc")
                    .resizable()
                    .frame(width: 150, height: 190)
                    .padding(.top, 50)
                    .foregroundColor(.accentColor)
                Text("mxlcdata.json")
                    .font(.headline)
                Button {
                    exportFile.toggle()
                } label: {
                    Text("movie-export-data")
                }
                .padding(.top, 50)
                .buttonStyle(.borderedProminent)
                .font(.title2)
                .fileExporter(isPresented: $exportFile, document: JsonFile(json: movieViewModel.getJSONData(run: exportFile) ?? ""), contentType: .json, defaultFilename: "mxlcdata") { result in
                    switch result {
                    case .success(_):
                        showingAlert.toggle()
                        dismiss()
                    case .failure(let failure):
                        fatalError(failure.localizedDescription)
                    }
                }
                .alert("movie-export-alert", isPresented: $showingAlert) {}
                Spacer()
            }
            .padding()
            .navigationBarTitle("setup-exportar-datos")
        }
    }
}

#Preview {
    MovieExportDataView()
        .environment(MovieViewModel())
}
