//
//  FoodViewModel.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/29/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation
import SwiftUI

class FoodDetail: ObservableObject {
    @Published var food: Food
    private var unitOptions: [FoodUnit] = [.each, .ounce, .pound]
    private static var decimalOptions: [Float] = [0, 0.125, 0.25, 0.33, 0.5,
                                                  0.66, 0.75, 0.875]
    
    init(food: Food) {
        self.food = food
        self.unitOptions = food.type.foodUnits()
    }
    
    var foodName: String {
        food.name
    }
    
    var foodType: FoodType {
        food.type
    }
    
    var foodAnount: FoodAmount {
        food.amount
    }
    
    var foodNutrient: Nutrient {
        food.nutrient
    }
    
    var foodCalorie: Int {
        food.calorie
    }
    
    func setAmount(intVal: Int, decimalVal: Int, mealList: MealList, dayLog: DayLog) -> Void {
        food.setAmount(to: Float(intVal) + FoodDetail.decimalOptions[decimalVal])
        mealList.setFood(food: food)
        dayLog.setMeal(meal: mealList.getMeal())
    }
    
    func setUnit(unitVal: Int, mealList: MealList, dayLog: DayLog) -> (Int, Int) {
        food.setUnit(to: unitOptions[unitVal])
        mealList.setFood(food: food)
        dayLog.setMeal(meal: mealList.getMeal())
        return FoodDetail.getIntegerDecimalLevels(floatNumber: food.amount.amount)
    }
    
    func saveFood(to mealList: MealList, dayLog: DayLog) -> Void {
        mealList.setFood(food: food)
        mealList.setFood(food: food)
        dayLog.setMeal(meal: mealList.getMeal())
        objectWillChange.send()
    }
    
    static func getIntegerDecimalLevels(floatNumber: Float) -> (Int, Int) {
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
        return (intVal, minIdx)
    }
}
