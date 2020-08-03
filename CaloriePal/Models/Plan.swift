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
}
