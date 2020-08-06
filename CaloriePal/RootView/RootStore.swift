//
//  RootStore.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/3/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class RootStore: ObservableObject {
    @Published var plan: Plan
    private(set) var lastAccessedDate: Date = Date()
    
    func setLastAccessedDate(to newDate: Date) -> Void {
        lastAccessedDate = newDate
    }
    
    init(plan: Plan) {
        self.plan = plan
    }
    
    func setPlan(plan: Plan) -> Void {
        self.plan = plan
    }
    
    func saveDay(day: Day) -> Void {
        plan.addDay(newDay: day)
    }
    
    func getToday() -> Day {
        if plan.hasRecord(on: Date()) {
            return plan.dayRecord(on: Date())!
        } else {
            return Day()
        }
    }
    
    func getDay(on date: Date) -> Day? {
        return plan.dayRecord(on: date)
    }
    
    func getOrCreateCurrentDay() -> Day {
        return plan.getOrCreateCurrentDay()
    }
    
//    func weekdays() -> [Day] {
//        plan.week
//    }
}
