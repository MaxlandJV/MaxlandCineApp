//
//  MaxlandCineApp.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 29/1/22.
//

import SwiftUI
import LocalAuthentication

@main
struct MaxlandCineApp: App {
    
    @State var movieViewModel = MovieViewModel()
    @State var isUnlocked = false
    @State var showAuthButton = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isUnlocked {
                    MovieListView()
                        .environment(movieViewModel)
                }
                else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            if (showAuthButton) {
                                Button {
                                    authenticate()
                                } label: {
                                    Text("auth-required")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    .background(LinearGradient(colors: [Color("TopColorGradient"), Color("BottomColorGradient")], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
            }
            .onAppear {
                movieViewModel.fetchOldMovies()
                authenticate()
            }
            .background(LinearGradient(colors: [Color("TopColorGradient"), Color("BottomColorGradient")], startPoint: .topLeading, endPoint: .bottomTrailing))
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
                    showAuthButton = true
                }
            }
        }
        else {
            // No se ha activado la autenticación biométrica
            isUnlocked = true
        }
    }
}
