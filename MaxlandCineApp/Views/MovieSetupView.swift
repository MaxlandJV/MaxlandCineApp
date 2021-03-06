//
//  MovieSetupView.swift
//  TestSwiftApp
//
//  Created by Jordi VillarĂ³ on 14/3/22.
//

import SwiftUI

struct MovieSetupView: View {
    
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    var body: some View {
        Form {
            Section(header: Text("setup-about")) {
                VStack(alignment: .leading) {
                    Image("MaxlandWorld")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("setup-details")
                }
                .padding(.vertical)
                Link("setup-code", destination: URL(string: "https://github.com/MaxlandJV/MaxlandCineApp")!)
                Link("setup-about-me", destination: URL(string: "https://www.linkedin.com/in/jordivilaro")!)
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
        }
        .navigationBarTitle("setup-title")
    }
}

struct MovieSetup_Previews: PreviewProvider {
    static var previews: some View {
        MovieSetupView()
    }
}
