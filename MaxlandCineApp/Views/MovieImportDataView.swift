//
//  MovieImportDataView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 31/1/23.
//

import SwiftUI

struct MovieImportDataView: View {
    
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
                do {
                    guard let selectedFile: URL = try? result.get() else { return }
                    guard let jsonData = String(data: try Data(contentsOf: selectedFile), encoding: .utf8)?.data(using: .utf8) else { return }
                    guard let json = try? JSONDecoder().decode([MovieImportExportModel].self, from: jsonData) else { return }
                } catch {
                    print("Error de importación")
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
