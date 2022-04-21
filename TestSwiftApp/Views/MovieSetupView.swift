//
//  MovieSetupView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 14/3/22.
//

import SwiftUI

struct MovieSetupView: View {
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    var body: some View {
        Form {
            Section {
                Toggle("Requerir autenticación", isOn: $movieViewModel.biometricAuth)
            } header: {
                Text("Autenticación biométrica")
            } footer: {
                Text("Cuando está habilitado, es necesario utilizar Face ID o Touch ID para acceder al contenido.")
            }
        }
        .navigationBarTitle("Configuración")
    }
}

struct MovieSetup_Previews: PreviewProvider {
    static var previews: some View {
        MovieSetupView()
    }
}
