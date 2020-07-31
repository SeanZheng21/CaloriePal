//
//  PieChartDataItem.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation
import SwiftUI

class PieChartDataItem {
    var name: String! = ""
    var value: Double = 0.0
    var color: Color! = .blue
    var highlighted: Bool = false
    
    init(name: String, value: Double, color: Color? = nil) {
        self.name = name
        self.value = value
        if let color = color {
            self.color = color
        } else {
            self.color = PieChartDataItem.random()
        }
    }
    
    static func random() -> Color {
        return Color(red: PieChartDataItem.randomColorRGB(),
                     green: PieChartDataItem.randomColorRGB(),
                     blue: PieChartDataItem.randomColorRGB())
    }
    
    static func randomColorRGB() -> Double {
        return Double(arc4random()) / Double(UInt32.max)
    }
}
