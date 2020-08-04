//
//  MealSummary.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class MealSummary: ObservableObject {
    @Published var meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    var totalCalories: Int {
        meal.totalCalories()
    }
    
    var totalNutrient: Nutrient {
        meal.totalNutrient()
    }
    
    var mealName: String {
        meal.name
    }
    
    var foods: [Food] {
        meal.foods
    }
    
    private var totalPercentageCalc: Float {
        totalNutrient.fatPercentage() +
            totalNutrient.carbsPercentage() +
            totalNutrient.proteinPercentage()
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
    
    func pieChartData() -> PieChartData {
        return PieChartData(data: [
            Double(totalNutrient.fatPercentage()),
            Double(totalNutrient.carbsPercentage()),
            Double(totalNutrient.proteinPercentage())
        ], colors: [
            Nutrient.fatColor,
            Nutrient.carbColor,
            Nutrient.proteinColor
        ])
    }
}
