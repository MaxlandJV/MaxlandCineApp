//
//  MovieSetupView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 14/3/22.
//

import SwiftUI

struct MovieSetupView: View {
    @Environment(\.openURL) var openURL
    @Bindable var movieViewModel: MovieViewModel
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Image("MaxlandWorld")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("Maxland Cine - 1.9.0")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                    Text("setup-details")
                        .foregroundColor(.gray)
                        .padding(.vertical, 0)
                }
            }
            
            Section(header: Text("setup-links")) {
                VStack(alignment: .leading) {
                    Button("setup-code") {
                        openURL(URL(string: "https://github.com/MaxlandJV/MaxlandCineApp")!, prefersInApp: true)
                    }
                }
                VStack(alignment: .leading) {
                    Button("setup-about-me") {
                        openURL(URL(string: "https://www.linkedin.com/in/jordivilaro")!, prefersInApp: true)
                    }
                }
            }
            
            if movieViewModel.biometricAuthUtil.biometricAuthActive() {
                Section {
                    Toggle("setup-auth", isOn: $movieViewModel.biometricAuth)
                } header: {
                    Text("setup-bioauth")
                } footer: {
                    Text("setup-auth-details")
                }
            }
            
            
            Section(header: Text("setup-copias-seguridad")) {
                if !movieViewModel.movieList.isEmpty {
                    VStack(alignment: .leading) {
                        NavigationLink {
                            MovieExportDataView()
                        } label: {
                            Text("setup-exportar-datos")
                        }
                    }
                }
                VStack(alignment: .leading) {
                    NavigationLink {
                        MovieImportDataView()
                    } label: {
                        Text("setup-importar-datos")
                    }
                }
            }
        }
       .navigationBarTitle("setup-title")
    }
}

#Preview {
    MovieSetupView(movieViewModel: MovieViewModel())
}
