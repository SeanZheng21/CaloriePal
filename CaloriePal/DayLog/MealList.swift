//
//  MealList.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/30/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class MealList: ObservableObject {
    @Published private var meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    var totalCalories: Int {
        meal.totalCalories()
    }
    
    func foods() -> [Food] {
        meal.foods
    }
    
    var mealName: String {
        meal.name
    }
    
    func getMeal() -> Meal {
        return meal
    }
    
    func setFood(food: Food) -> Void {
        meal.setFood(food: food)
    }
    
    func addFood(newFood: Food) -> Void {
        meal.addFood(newFood: newFood)
    }
    
    func removeFood(food: Food) -> Void {
        meal.removeFood(food: food)
    }
    
    func getFood(of id: Int) -> Food? {
        return meal.foods.first(where: {$0.id == id})
    }
    
    func deleteFood(at indexSet: IndexSet) {
        let foodToDelete = meal.foods[indexSet.first!]
        self.removeFood(food: foodToDelete)
        objectWillChange.send()
    }
}
