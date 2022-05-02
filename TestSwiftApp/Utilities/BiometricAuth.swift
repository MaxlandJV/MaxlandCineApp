//
//  BiometricAuth.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 26/4/22.
//

import Foundation
import LocalAuthentication

class BiometricAuth: ObservableObject {
    
    private var error: NSError?
    private let laContext: LAContext
    private let existBiometricAuth: Bool
    
    @Published var isAuth: Bool = false
    
    init() {
        laContext = LAContext()
        
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            existBiometricAuth = true
        }
        else {
            existBiometricAuth = false
        }
    }
    
    func authentication() {
        if existBiometricAuth {
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Se ha solicitado autentificación biométrica") { authenticated, error in
                print(authenticated, error)
                if authenticated  {
                    self.isAuth = true
                }
                else {
                    self.isAuth = false
                }
            }
        }
        else {
            self.isAuth = true
        }
    }
    
    func biometricAuthActive() -> Bool {
        return existBiometricAuth
    }
}
