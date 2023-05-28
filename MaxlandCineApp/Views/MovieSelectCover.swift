//
//  MovieSelectCover.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 28/5/23.
//

import SwiftUI
import PhotosUI

struct MovieSelectCover: View {
    @State var caratula: Data = .init(count: 0)
    @State private var items: [PhotosPickerItem] = []
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $items, maxSelectionCount: 1, matching: .images) {
                if items.count != 0 {
                    if let uiCaratura = UIImage(data: caratula) {
                        Image(uiImage: uiCaratura)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    }
                }
                else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
}

struct MovieSelectCover_Previews: PreviewProvider {
    static var previews: some View {
        MovieSelectCover()
    }
}
