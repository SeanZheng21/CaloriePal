//
//  DaySummary.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/2/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class DayBanner: ObservableObject {
    @Published private var day: Day
    
    init(day: Day) {
        self.day = day
    }
    
    var budgetCalories: Int {
        day.budgetCalories
    }
    
    var foodCalories: Int {
        day.foodCalories()
    }
    
    var exerciseCalories: Int {
        day.exerciseCalories()
    }
    
    var netCalories: Int {
        day.totalCalories()
    }
    
    var remainingCalories: Int {
        day.remainingCalories()
    }
    
    var totalNutrient: Nutrient {
        day.totalNutrients()
    }
    
    private var totalPercentageCalc: Float {
        totalNutrient.fatPercentage() +
            totalNutrient.carbsPercentage() +
            totalNutrient.proteinPercentage()
    }
    
    func getDay() -> Day {
        return day
    }
    
    var fatPercentage: Int {
        Int(totalNutrient.fatPercentage() / totalPercentageCalc * 100)
    }
    
    var carbsPercentage: Int {
        Int(totalNutrient.carbsPercentage() / totalPercentageCalc * 100)
    }
    
    var proteinPercentage: Int {
        Int(totalNutrient.proteinPercentage() / totalPercentageCalc * 100)
    }
}
