//
//  Plan.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/3/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

struct Plan: Hashable, Codable, Identifiable {
    static private var _id = 30000
    var id: Int
    private(set) var days: [Day]
    private(set) var startDate: Date
    private(set) var endDate: Date
    private(set) var goal: Float
    private(set) var rate: Float
    private(set) var caloriesPerDay: Float
    private(set) var weights: [Date: Float]

    init(from startDate: Date, to endDate: Date, startWeight: Float, goalWeight: Float, rate: Float) {
        self.id = Plan._id
        Plan._id += 1
        days = []
        self.startDate = startDate
        self.endDate = endDate
        self.goal = goalWeight
        self.rate = rate
        self.weights = [startDate: startWeight]
        self.caloriesPerDay = 1500
    }
    
    mutating func getOrCreateCurrentDay() -> Day {
        if hasRecord(on: Date()) {
            return dayRecord(on: Date())!
        } else {
            let today = Day()
            days.append(today)
            return today
        }
    }
    
    mutating func addDay(newDay: Day) -> Void {
        if hasRecord(on: newDay.date) {
            removeDay(on: newDay.date)
        }
        days.append(newDay)
    }
    
    mutating func removeDay(on date: Date) -> Void {
        if hasRecord(on: date) {
            days.removeAll(where: {
                $0.date.onSameDay(otherDate: date)
            })
        }
    }
    
    func hasRecord(on date: Date) -> Bool {
        return dayRecord(on: date) != nil
    }
    
    func dayRecord(on date: Date) -> Day? {
        return days.first(where: {
            $0.date.onSameDay(otherDate: date)
        })
    }

    
    mutating func previousDay(withRespectTo day: Day) -> Day {
        days.sort(by: { (day1, day2) in
            day1.date < day2.date
        })
        if let dayIdx = days.firstIndex(where: {$0.date.onSameDay(otherDate: day.date)}) {
            return days[max(0, dayIdx - 1)]
        } else {
            return day
        }
    }
    
    mutating func followingDay(withRespectTo day: Day) -> Day {
        days.sort(by: { (day1, day2) in
            day1.date < day2.date
        })
        if let dayIdx = days.firstIndex(where: {$0.date.onSameDay(otherDate: day.date)}) {
            return days[min(days.count - 1, dayIdx + 1)]
        } else {
            return day
        }
    }
    
    func weekdaysInWeek(withRespectTo date: Date) -> [Day] {
        var weekdays: [Day] = []
        for shiftedDate in date.weekdaysInWeek() {
            if hasRecord(on: shiftedDate) {
                let d: Day = dayRecord(on: shiftedDate)!
                weekdays.append(d)
            }
        }
        return weekdays
    }
    
    func weekdaysCalories(withRespectTo date: Date) -> Int {
        var cal = 0
        weekdaysInWeek(withRespectTo: date).forEach {
            cal += $0.totalCalories()
        }
        return cal
    }
    
    func weekdaysNetCalories(withRespectTo date: Date) -> Int {
        let cal = weekdaysCalories(withRespectTo: date)
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let currentWeekdayInt = (calendar?.component(NSCalendar.Unit.weekday, from: date))!
        return currentWeekdayInt * Int(caloriesPerDay) - cal
    }
    
    func weekdaysNutrients(withRespectTo date: Date) -> Nutrient {
        var nutrient = Nutrient(fat: 0, satFat: 0, cholesterol: 0, sodium: 0, carbs: 0, fiber: 0, sugars: 0, protein: 0)
        weekdaysInWeek(withRespectTo: date).forEach {
            nutrient = nutrient.addNutrient(otherNutrient: $0.totalNutrients())
        }
        return nutrient
    }
    
//    func weekdays(withRespectTo date: Date) -> [Date: Day?] {
//        var weekdays: [Date: Day?] = [:]
//        let daysArr = weekdaysInWeek(withRespectTo: date)
//        for shiftedDate in date.weekdaysInWeek() {
//            let otherDay = daysArr.first(where: { $0.date.onSameDay(otherDate: shiftedDate) })
//            weekdays[shiftedDate] = otherDay
//        }
//        return weekdays
//    }
}

extension Date {
    func onSameDay(otherDate: Date) -> Bool {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let currentMonthInt = (calendar?.component(NSCalendar.Unit.month, from: self))!
        let currentYearInt = (calendar?.component(NSCalendar.Unit.year, from: self))!
        let currentDayInt = (calendar?.component(NSCalendar.Unit.day, from: self))!
        let otherMonthInt = (calendar?.component(NSCalendar.Unit.month, from: otherDate))!
        let otherYearInt = (calendar?.component(NSCalendar.Unit.year, from: otherDate))!
        let otherDayInt = (calendar?.component(NSCalendar.Unit.day, from: otherDate))!
        return (currentDayInt == otherDayInt) &&
            (currentMonthInt == otherMonthInt) &&
            (currentYearInt == otherYearInt)
    }
    
    func weekdaysInWeek() -> [Date] {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let currentWeekdayInt = (calendar?.component(NSCalendar.Unit.weekday, from: self))!
        var weekdays: [Date] = []
        for i in (1-currentWeekdayInt)...(7-currentWeekdayInt) {
            let shiftedDate = Date(timeIntervalSinceNow: 24*60*60*Double(i))
            weekdays.append(shiftedDate)
        }
        return weekdays
    }
}
