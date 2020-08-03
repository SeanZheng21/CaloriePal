//
//  DayLog.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class DayLog: ObservableObject {
    @Published var day: Day
    private var plan: Plan
    
    init(plan: Plan) {
        self.plan = plan
        self.day = self.plan.getOrCreateCurrentDay()
    }
    
    var dateString: String { day.dateString() }
    
    var breakfast: Meal { day.breakfast }
    
    var lunch: Meal { day.lunch }
    
    var dinner: Meal { day.dinner }
    
    var snacks: Meal { day.snacks }
    
    var exercise: Exercise { day.exercise }
    
    func setMeal(meal: Meal) -> Void {
        day.setMeal(to: meal)
        plan.addDay(newDay: day)
    }
    
    func setExercise(exercise: Exercise) -> Void {
        day.setExercise(to: exercise)
        plan.addDay(newDay: day)
    }
    
    func setPreviousDay() -> Void {
        day = plan.previousDay(withRespectTo: day)
    }

    func setFollowingDay() -> Void {
        day = plan.followingDay(withRespectTo: day)
    }

    func setToDate(date: Date) -> Bool {
        if let targetDay = plan.dayRecord(on: date) {
            day = targetDay
            return true
        } else {
            return false
        }
    }
}
