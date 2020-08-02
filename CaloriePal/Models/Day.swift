//
//  Day.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

struct Day: Hashable, Codable, Identifiable {
    private static let _defaultBudgetCalories: Int = 1500
    var id: Int
    private(set) var budgetCalories: Int
    private(set) var date: Date
    private(set) var breakfast: Meal
    private(set) var lunch: Meal
    private(set) var dinner: Meal
    private(set) var snacks: Meal
    private(set) var exercise: Exercise
    
    init(budgetCalories: Int?=nil, date: Date?=nil, breakfast: Meal?=nil, lunch: Meal?=nil, dinner: Meal?=nil, snacks: Meal?=nil, exercise: Exercise?=nil) {
        if let d = date {
            self.date = d
        } else {
            self.date = Date()
        }
        self.budgetCalories = budgetCalories ?? Day._defaultBudgetCalories
        self.id = Int(self.date.timeIntervalSince1970)
        self.breakfast = breakfast ?? Meal(type: .breakfast)
        self.lunch = lunch ?? Meal(type: .lunch)
        self.dinner = dinner ?? Meal(type: .dinner)
        self.snacks = snacks ?? Meal(type: .snacks)
        self.exercise = exercise ?? Exercise()
    }
    
    func meals() -> [Meal] {
        [breakfast, lunch, dinner, snacks]
    }
    
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    func foodCalories() -> Int {
        var totalCal = 0
        for meal in meals() {
            totalCal += meal.totalCalories()
        }
        return totalCal
    }
    
    func exerciseCalories() -> Int {
        exercise.totalCalories()
    }
    
    func totalCalories() -> Int {
        return foodCalories() - exerciseCalories()
    }
    
    func remainingCalories() -> Int {
        budgetCalories - totalCalories()
    }
    
    func totalNutrients() -> Nutrient {
        var nutrient = Nutrient(fat: 0, satFat: 0, cholesterol: 0, sodium: 0, carbs: 0, fiber: 0, sugars: 0, protein: 0)
        for meal in meals() {
            nutrient = nutrient.addNutrient(otherNutrient: meal.totalNutrient())
        }
        return nutrient
    }
}
