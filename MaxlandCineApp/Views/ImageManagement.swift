//
//  ImageManagement.swift
//  MaxlandCineApp
//
//  Created by Jordi Villaró on 25/7/23.
//

import Foundation
import SwiftUI

struct ImageManagement {
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        if size.width <= 1024 { return image }
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Se elige el radio más bajo para que la imagen se ajuste adecuadamente
        let ratio = min(widthRatio, heightRatio)
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let renderFormat = UIGraphicsImageRendererFormat.default()
        let renderer = UIGraphicsImageRenderer(size: newSize, format: renderFormat)
        let newImage = renderer.image { context in
            image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        }
        
        guard let imageData = newImage.jpegData(compressionQuality: 0.8) else { return image } // 0.8 es el nivel de compresión
        return UIImage(data: imageData)!
    }
}
