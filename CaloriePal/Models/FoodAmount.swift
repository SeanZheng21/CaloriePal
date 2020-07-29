//
//  FoodAmount.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/28/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

struct FoodAmount: Hashable, Codable, CustomStringConvertible {
    var unit: String
    var amount: Float
    var multiplier: Float
    
    var description: String {
        "\(Nutrient.formatNutrient(amount)) \(unit.pluralize(by: amount))"
    }
}

extension String {
    func pluralize(by multiplier: Float) -> String {
        return multiplier > 1 ? self + "s" : self
    }
}
