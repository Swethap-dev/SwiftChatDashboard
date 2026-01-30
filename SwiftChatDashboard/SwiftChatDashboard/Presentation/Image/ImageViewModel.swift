//
//  ImageViewModel.swift
//  SwiftChatDashboard
//
//  Created by swetha on 30/01/26.
//


import Foundation
import SwiftUI

@MainActor
class ImageViewModel: ObservableObject {
    @Published var images: [ImageEntity] = []
    
    func addImage(_ uiImage: UIImage) {
        let newImage = ImageEntity(image: uiImage)
        images.append(newImage)
    }
}
