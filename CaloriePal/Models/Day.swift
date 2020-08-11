//
//  Day.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation
import Combine

struct Day: Hashable, Codable, Identifiable {
    private static let _defaultBudgetCalories: Int = 1500
    var id: Int
    private(set) var budgetCalories: Int
    private(set) var weight: Float? = nil
    private(set) var date: Date
    private(set) var breakfast: Meal
    private(set) var lunch: Meal
    private(set) var dinner: Meal
    private(set) var snacks: Meal
    private(set) var exercise: Exercise
    
    init(budgetCalories: Int?=nil, date: Date?=nil, breakfast: Meal?=nil, lunch: Meal?=nil,
         dinner: Meal?=nil, snacks: Meal?=nil, exercise: Exercise?=nil, weight: Float?=nil) {
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
        self.weight = weight
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(self.date)
    }
    
    var hashValue: Int {
        date.hashValue
    }
    
    func meals() -> [Meal] {
        [breakfast, lunch, dinner, snacks]
    }
    
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        return formatter.string(from: date)
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
    
    mutating func setMeal(to meal: Meal) -> Void {
        switch meal.type {
        case .breakfast:
            self.breakfast = meal
        case .lunch:
            self.lunch = meal
        case .dinner:
            self.dinner = meal
        case .snacks:
            self.snacks = meal
        }
    }
    
    func getMeal(of mealType: MealType) -> Meal {
        switch mealType {
            case .breakfast:
                return self.breakfast
            case .lunch:
                return self.lunch
            case .dinner:
                return self.dinner
            case .snacks:
                return self.snacks
        }
    }
    
    mutating func setExercise(to exercise: Exercise) -> Void {
        self.exercise = exercise
    }
    
    func hasWeight() -> Bool {
        self.weight != nil
    }
    
    mutating func setWeight(to newWeight: Float) -> Void {
        weight = newWeight
    }
}
