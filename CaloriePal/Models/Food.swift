//
//  Food.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/28/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

struct Food: Hashable, Codable, Identifiable {
    var id: Int
    private(set) var name: String
    private(set) var nutrient: Nutrient
    private(set) var caloriePerUnit: Int
    private(set) var amount: FoodAmount
    private(set) var type: FoodType
    
    static func == (lhs: Food, rhs: Food) -> Bool {
        lhs.id == rhs.id
    }
    
    var calorie: Int {
        Int(amount.amount * Float(caloriePerUnit))
    }
    
    mutating func setAmount(to amount: Float) -> Void {
        self.amount = FoodAmount(unit: self.amount.unit, amount: amount)
    }
    
    mutating func setUnit(to unit: FoodUnit) -> Void {
        let newAmountValue = amount.convert(to: unit)
        self.amount = FoodAmount(unit: unit, amount: newAmountValue)
    }
    
    func toJsonString() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}
