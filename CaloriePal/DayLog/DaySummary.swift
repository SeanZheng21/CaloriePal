//
//  DaySummary.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/2/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class DaySummary: ObservableObject {
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
    
}
