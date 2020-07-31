//
//  Nutrient.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/28/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation
import SwiftUI

struct Nutrient: Hashable, Codable {
    var fat: Float
    var satFat: Float
    var cholesterol: Float
    var sodium: Float
    var carbs: Float
    var fiber: Float
    var sugars: Float
    var protein: Float
    
    var sum: Float {
        fat + satFat + (cholesterol + sodium) / 1000 +
            carbs + fiber + sugars + protein
    }
    
    static func formatNutrient(_ amount: Float) -> String {
        var str = String(format: "%.2f", amount)
        while (str.hasSuffix("0") || str.hasSuffix(".")) && str.count > 1 {
            str.removeLast(1)
        }
        return str
    }
    
    func fatPercentage() -> Float {
        fat / sum * Nutrient.fatPounderedRatio
    }
    
    func carbsPercentage() -> Float {
        carbs / sum * Nutrient.carbPounderedRatio
    }
    
    func proteinPercentage() -> Float {
        protein / sum * Nutrient.proteinPounderedRatio
    }
    
    func addNutrient(otherNutrient: Nutrient) -> Nutrient {
        return Nutrient(fat: self.fat + otherNutrient.fat,
                        satFat: self.satFat + otherNutrient.satFat,
                        cholesterol: self.cholesterol + otherNutrient.cholesterol,
                        sodium: self.sodium + otherNutrient.sodium,
                        carbs: self.carbs + otherNutrient.carbs,
                        fiber: self.fiber + otherNutrient.fiber,
                        sugars: self.sugars + otherNutrient.sugars,
                        protein: self.protein + otherNutrient.protein)
    }
    
    // Poundered ratio for percentage calculation
    // Percentage = real percentage w.r.t. Nutrient.sum * poundered ratio
    private static let fatPounderedRatio: Float = 2.36
    private static let carbPounderedRatio: Float = 1.055
    private static let proteinPounderedRatio: Float = 1.032
    
    static let fatColor: Color = Color(#colorLiteral(red: 0.9176470588, green: 0.7568627451, blue: 0.4078431373, alpha: 1))
    static let carbColor: Color = Color(#colorLiteral(red: 0.5058823529, green: 0.7725490196, blue: 0.9058823529, alpha: 1))
    static let proteinColor: Color = Color(#colorLiteral(red: 0.3960784314, green: 0.2588235294, blue: 0.9215686275, alpha: 1))
}
