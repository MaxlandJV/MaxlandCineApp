//
//  MovieImportDataView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 31/1/23.
//

import SwiftUI

struct MovieImportDataView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State private var pickFile: Bool = false
    @State private var fileURL: URL?
    @State var showingAlert = false
    
    var body: some View {
        VStack {
            Text("movie-import-detail1")
                .font(.headline)
            Image(systemName: "arrow.up.doc")
                .resizable()
                .frame(width: 150, height: 190)
                .padding(.top, 50)
                .foregroundColor(.accentColor)
            Text("movie-import-detail2")
                .font(.headline)
                .foregroundColor(.red)
                .padding(.top, 10)
            Button {
                pickFile.toggle()
            } label: {
                Text("movie-import-data")
            }
            .padding(.top, 20)
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .fileImporter(isPresented: $pickFile, allowedContentTypes: [.json]) { result in
                movieViewModel.setJSONData(moviesJSON: result)
                showingAlert.toggle()
                dismiss()
            }
            .alert("movie-import-alert", isPresented: $showingAlert) {}
            //.quickLookPreview($fileURL)
            Spacer()
        }
        .padding()
        .navigationBarTitle("setup-importar-datos")
    }
}

struct MovieImportDataView_Previews: PreviewProvider {
    static var previews: some View {
        MovieImportDataView()
    }
}
