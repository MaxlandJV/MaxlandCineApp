//
//  MovieListRowView.swift
//  TestSwiftApp
//
//  Created by Jordi Villaró on 4/2/22.
//

import SwiftUI

struct MovieListRowView: View {
    let movieName: String?
    let showDate: Date?
    let sinopsis: String?
    let score: Int16?
    let isSerie: Bool?
    let caratula: Data?
    
    var body: some View {
        HStack {
            if let imageData = caratula,
               let selectedImage = UIImage(data: imageData) {
                Image(uiImage: selectedImage)
                    .resizable()
                    .frame(width: 100)
            }
            else {
                if (isSerie != nil) {
                    Image(systemName: isSerie! ? "sparkles.tv" : "film")
                        .resizable()
                        .frame(width: 96)
                        .foregroundColor(isSerie! ? Color("Serie") : Color("Movie"))
                        .padding(.vertical, 4)
                        .padding(.leading, 4)
                }
                else {
                    Image(systemName: "film")
                        .resizable()
                        .frame(width: 96)
                        .foregroundColor(Color("Movie"))
                        .padding(.vertical, 4)
                        .padding(.leading, 4)
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(movieName ?? "")
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                Spacer()
                HStack {
                    HStack(spacing: 0) {
                        ForEach(1...5, id: \.self) { number in
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .foregroundColor(number > score ?? 0 ? Color("StarNoActive") : .yellow)
                        }
                    }
                    Spacer()
                    Text(showDate ?? Date(), style: .date)
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.black)
                }
            }
            .frame(height: 100)
            Image(systemName: "chevron.forward")
                .padding(0)
                .foregroundColor(.black)
        }
        .background(LinearGradient(colors: [Color.clear, Color.white], startPoint: .trailing, endPoint: .leading))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 0)
        .frame(height: 120)
    }
}

#Preview {
    MovieListRowView(movieName: "Prueba de película con un nombre largo", showDate: Date(), sinopsis: "", score: 3, isSerie: false, caratula: nil)
        .padding()
        .previewLayout(.sizeThatFits)
}
