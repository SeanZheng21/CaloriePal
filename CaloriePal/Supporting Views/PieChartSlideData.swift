//
//  PieChartSlideData.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation
import SwiftUI

class PieChartSlideData: Identifiable, ObservableObject {
    let id: UUID = UUID()
    var data: PieChartDataItem!
    var startAngle: Angle! = .degrees(0)
    var endAngle: Angle! = .degrees(0)
    
    var annotation: String! = ""
    var annotationDeltaX: CGFloat! = 0.0
    var annotationDeltaY: CGFloat! = 0.0
    
    var deltaX: CGFloat! = 0.0
    var deltaY: CGFloat! = 0.0
    
    init() { }
    
    init(startAngle: Angle, endAngle: Angle) {
        self.data = PieChartDataItem(name: "", value: 0)
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
}
