//
//  FoodType.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/28/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

enum FoodType: String, CaseIterable, Codable, Hashable {
    case each = "each"
    case drink = "drink"
    case weight = "weight"
    
    func foodUnits() -> [FoodUnit] {
        switch self {
        case .drink:
            return [.teaspoon, .tablespoon, .cup,
                    .fluidOunce, .liter, .pint,
                    .quart, .ounce, .pound, .gram, .milliliter]
        case .weight:
            return [.ounce, .pound, .gram]
        case .each:
            return [.each, .ounce, .pound, .gram]
        }
    }
}

enum FoodUnit: String, CaseIterable, Codable, Hashable {
    case teaspoon = "teaspoon"
    case tablespoon = "tablespoon"
    case cup = "cup"
    case fluidOunce = "fluid ounce"
    case liter = "liter"
    case pint = "pint"
    case quart = "quart"
    case ounce = "ounce"
    case pound = "pound"
    case gram = "gram"
    case milliliter = "milliliter"
    case each = "each"
    
    static private var conversionTable: [FoodUnit: Float] =
        [
            .teaspoon: 204,
             .tablespoon: 68,
             .cup: 4.25,
             .fluidOunce: 33.875,
             .liter: 1,
             .pint: 2.125,
             .quart: 1,
             .ounce: 35,
             .pound: 2.125,
             .gram: 992,
             .milliliter: 946.33,
             // TODO: Customizable each weight
             .each: 6.375
        ]
        
    func convert(of amount: Float, to targetUnit: FoodUnit) -> Float {
        let selfVal = FoodUnit.conversionTable[self]!
        let dstVal = FoodUnit.conversionTable[targetUnit]!
        let unroundedResult = amount * dstVal / selfVal
        return FoodUnit.getRoundedFloat(floatNumber: unroundedResult)
    }
    
    static private func getRoundedFloat(floatNumber: Float) -> Float {
        let decimalOptions: [Float] = [0, 0.125, 0.25, 0.33, 0.5,
                                       0.66, 0.75, 0.875]
        
        var intVal = Int(floatNumber)
        let decimal: Float = floatNumber - Float(intVal)
        var minIdx: Int = -1
        var minError: Float = 1.0
        for i in 0..<decimalOptions.count {
            let error = decimal > decimalOptions[i]
                ? decimal - decimalOptions[i] : decimalOptions[i] - decimal
            if minError > error {
                minError = error
                minIdx = i
            }
        }
        if decimal > 0.93 {
            minIdx = 0
            intVal += 1
        }
        return Float(intVal) + decimalOptions[minIdx]
    }
}
