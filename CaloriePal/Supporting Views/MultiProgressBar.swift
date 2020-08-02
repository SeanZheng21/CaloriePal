//
//  MultiProgressBar.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/2/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation
import SwiftUI

class MultiProgressBar: ObservableObject {
    private var total: Float
    @Published var values: [Float]
    private var colors: [Color]
    
    init(total: Float, values: [Float], colors: [Color]) {
        self.values = []
        self.colors = []
        self.total = total
        if values.count <= colors.count {
            for i in 0..<values.count {
                self.values.append(values[i]/total)
                self.colors.append(colors[i])
            }
        } else {
            for i in 0..<colors.count {
                self.values.append(values[i]/total)
                self.colors.append(colors[i])
            }
            for j in colors.count..<values.count {
                self.values.append(values[j]/total)
                self.colors.append(PieChartDataItem.random())
            }
        }
    }
    
    func valuesCount() -> Int {
        return values.count
    }

    func itemValue(at index: Int) -> Float? {
        if values.indices.contains(index) {
            return values[index]
        } else {
            return nil
        }
    }
    
    func itemColor(at index: Int) -> Color? {
        if colors.indices.contains(index) {
            return colors[index]
        } else {
            return nil
        }
    }
    
}
