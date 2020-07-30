//
//  FoodAmount.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/28/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

struct FoodAmount: Hashable, Codable, CustomStringConvertible {
    var unit: FoodUnit
    var amount: Float
    
    var description: String {
        "\(Nutrient.formatNutrient(amount)) \(unit.rawValue.pluralize(by: amount))"
    }
    
    static func units(of foodType: FoodType) -> [FoodUnit] {
        foodType.foodUnits()
    }
    
    func convert(to dstUnit: FoodUnit) -> Float {
        self.unit.convert(of: amount, to: dstUnit)
    }
}

extension String {
    func pluralize(by multiplier: Float) -> String {
        return multiplier > 1 ? self + "s" : self
    }
}
