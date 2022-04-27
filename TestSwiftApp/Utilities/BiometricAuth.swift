//
//  BiometricAuth.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 26/4/22.
//

import Foundation
import LocalAuthentication

class BiometricAuth {
    private var error: NSError?
    private let laContext: LAContext
    private let existBiometricAuth: Bool
    
    init() {
        laContext = LAContext()
        
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            existBiometricAuth = true
        }
        else {
            existBiometricAuth = false
        }
    }
    
    func authentication() -> Bool {
        var isAuth = false
        
        if existBiometricAuth {
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Se ha solicitado autentificación biométrica") { authenticated, error in
                if authenticated  {
                    isAuth = true
                }
                else {
                    isAuth = false
                }
            }
        }
        else {
            isAuth = true
        }
        
        return isAuth
    }
    
    func biometricAuthActive() -> Bool {
        return existBiometricAuth
    }
}
