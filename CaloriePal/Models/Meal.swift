//
//  Meal.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/30/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

struct Meal: Hashable, Codable, Identifiable  {
    var id: Int
    private(set) var type: MealType
    private(set) var foods: [Food]
    
    var name: String {
        type.rawValue
    }
    
    mutating func addFood(newFood: Food) -> Void {
        if let existingIndex = foodIndex(of: newFood) {
            foods.remove(at: existingIndex)
            foods.insert(newFood, at: existingIndex)
        } else {
            foods.append(newFood)
        }
    }
    
    mutating func removeFood(food: Food) -> Void {
        if let existingIndex = foodIndex(of: food) {
            foods.remove(at: existingIndex)
        }
    }
    
    mutating func setFood(food: Food) -> Void {
        if let existingIndex = foodIndex(of: food) {
            foods.remove(at: existingIndex)
            foods.insert(food, at: existingIndex)
        }
    }
    
    func foodIndex(of food: Food) -> Int? {
        return foods.firstIndex(where: {$0.id == food.id})
    }
    
    func hasFood(food: Food) -> Bool {
        return foodIndex(of: food) != nil
    }
    
    func food(at index: Int) -> Food? {
        if foods.indices.contains(index) {
            return foods[index]
        } else {
            return nil
        }
    }
    
    func totalCalories() -> Int {
        var sum = 0
        for food in foods {
            sum += food.calorie
        }
        return sum
    }
    
    func totalNutrient() -> Nutrient {
        var sumNutrient = Nutrient(fat: 0, satFat: 0, cholesterol: 0, sodium: 0, carbs: 0, fiber: 0, sugars: 0, protein: 0)    
        foods.forEach { sumNutrient = sumNutrient.addNutrient(otherNutrient: $0.nutrient) }
        return sumNutrient
    }
}
