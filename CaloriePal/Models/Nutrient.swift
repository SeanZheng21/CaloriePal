//
//  Nutrient.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/28/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

struct Nutrient: Hashable, Codable {
    var fat: Float
    var satFat: Float
    var cholesterol: Float
    var sodium: Float
    var carbs: Float
    var fiber: Float
    var sugars: Float
    var protein: Float
    
    static func formatNutrient(_ amount: Float) -> String {
        var str = String(format: "%.2f", amount)
        while str.hasSuffix("0") || str.hasSuffix(".") {
            str.removeLast(1)
        }
        return str
    }
}
