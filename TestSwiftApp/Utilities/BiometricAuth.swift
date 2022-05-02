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
    
    init() {
        laContext = LAContext()
        
        if laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            existBiometricAuth = true
        }
        else {
            existBiometricAuth = false
        }
    }
        
    func biometricAuthActive() -> Bool {
        return existBiometricAuth
    }
}
