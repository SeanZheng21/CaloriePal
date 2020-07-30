//
//  ServingSizeCard.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/30/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct ServingSizeCard: View {
    private var servingSizeImageIndex: Int
    private var imageScale: CGFloat
    var body: some View {
        Image(ImageStore.loadImage(name: "Serving Size \(servingSizeImageIndex)", imageExtension: "png"),
        scale: self.imageScale, label: Text(""))
    }
    
    init(servingSizeImageIndex: Int, imageScale: CGFloat=ServingSizeCard.defaultImageScale) {
        self.servingSizeImageIndex = servingSizeImageIndex
        self.imageScale = imageScale
    }
    
    //MARK: Drawing Constants
    private static let defaultImageScale: CGFloat = 1.8
}

struct ServingSizeCard_Previews: PreviewProvider {
    static var previews: some View {
        ServingSizeCard(servingSizeImageIndex: 1)
            .aspectRatio(3/2, contentMode: .fit)
    }
}
