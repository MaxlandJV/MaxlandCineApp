//
//  TestSwiftAppApp.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI
import LocalAuthentication

@main
struct MaxlandCineApp: App {
    
    @StateObject var movieViewModel = MovieViewModel()
    @State var isUnlocked = false
    
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 0) {
                if isUnlocked {
                    MovieListView()
                        .environmentObject(movieViewModel)
                }
                else {
                    Button {
                        authenticate()
                    } label: {
                        Text("Autenticación requerida")
                    }

                }
            }
            .onAppear(perform: authenticate)
        }
    }
    
    func authenticate() {
        let laContext = LAContext()

        // Comprobar si está activa la autenticación
        if movieViewModel.biometricAuth {
            let reason = "Es necesaria la autenticación biométrica."

            // Autentificar
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // Autenticación realizada
                if success {
                    // Autenticación correcta
                    isUnlocked = true
                } else {
                    // Problema en la autenticación
                    isUnlocked = false
                }
            }
        }
        else {
            // No se ha activado la autenticación biométrica
            isUnlocked = true
        }
    }
}
