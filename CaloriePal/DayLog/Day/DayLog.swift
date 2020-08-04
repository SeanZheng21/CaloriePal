//
//  DayLog.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class DayLog: ObservableObject {
    @Published var day: Day {
        didSet {
            print("Set day to \(day.dateString())")
        }
    }
//    private var plan: Plan
    
    init(day: Day) {
        self.day = day
//        self.day = self.plan.getOrCreateCurrentDay()
    }
    
    var dateString: String { day.dateString() }
    
    var breakfast: Meal { day.breakfast }
    
    var lunch: Meal { day.lunch }
    
    var dinner: Meal { day.dinner }
    
    var snacks: Meal { day.snacks }
    
    var exercise: Exercise { day.exercise }
    
    func setMeal(meal: Meal, rootStore: RootStore) -> Void {
        day.setMeal(to: meal)
        rootStore.plan.addDay(newDay: day)
    }
    
    func setExercise(exercise: Exercise, rootStore: RootStore) -> Void {
        day.setExercise(to: exercise)
        rootStore.plan.addDay(newDay: day)
    }
    
    func setPreviousDay(rootStore: RootStore) -> Date {
        let previousDay = rootStore.plan.previousDay(withRespectTo: day)
//        let _ = setToDate(date: previousDay.date, rootStore: rootStore)
        self.day = previousDay
//        print("Set previous date to \(previousDay.dateString())")
        rootStore.setLastAccessedDate(to: previousDay.date)
        objectWillChange.send()
        return day.date
    }

    func setFollowingDay(rootStore: RootStore) -> Date {
        let followingDay = rootStore.plan.followingDay(withRespectTo: day)
//        let _ = setToDate(date: followingDay.date, rootStore: rootStore)
        self.day = followingDay
        rootStore.setLastAccessedDate(to: followingDay.date)
        objectWillChange.send()
        return day.date
    }

    func setToDate(date: Date, rootStore: RootStore) -> Bool {
//        print("Set date to \(date.description)")
        if let targetDay = rootStore.plan.dayRecord(on: date) {
            day = targetDay
            rootStore.setLastAccessedDate(to: day.date)
            objectWillChange.send()
            return true
        } else {
            return false
        }
    }
}
