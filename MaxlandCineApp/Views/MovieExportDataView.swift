//
//  MovieExportDataView.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 16/12/22.
//

import SwiftUI

struct MovieExportDataView: View {
    
    @State private var exportFile: Bool = false
    
    var body: some View {
        VStack {
            Button {
                exportFile.toggle()
            } label: {
                Text("Exportar")
            }
//            .fileExporter(isPresented: $exportFile, documents: <#T##Collection#>, contentType: .json) { result in
//                switch result {
//                case .success(let success):
//                    print("Exportado correctamente")
//                case .failure(let failure):
//                    print(failure.localizedDescription)
//                }
//            }


        }
        .navigationBarTitle("setup-exportar-datos")
    }
}

struct MovieExportDataView_Previews: PreviewProvider {
    static var previews: some View {
        MovieExportDataView()
    }
}
