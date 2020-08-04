//
//  ServingSizeView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/30/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct ServingSizeView: View {
    var body: some View {
        PageView(ServingSizeView.cardRange.map { ServingSizeCard(servingSizeImageIndex: $0) })
            .aspectRatio(ServingSizeView.drawingAspectRatio, contentMode: .fit)
    }
    
    // MARK: - Drawing Constants
    static let drawingAspectRatio: CGFloat = 1.1
    private static let cardRange = [Int](0...8)
}

struct ServingSizeView_Previews: PreviewProvider {
    static var previews: some View {
        ServingSizeView()
    }
}
