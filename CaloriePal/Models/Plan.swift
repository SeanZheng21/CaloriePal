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
    // Male = true, female = false
    private(set) var gender: Bool
    // In foot
    private(set) var height: Float
    private(set) var age: Int
    private(set) var activityLevel: Int
    private(set) var goal: Float
    private(set) var rate: Float
    private(set) var startWeight: Float?

    init(gender: Bool, height: Float, age: Int, activityLevel: Int, from startDate: Date, startWeight: Float, goalWeight: Float, rate: Float) {
        self.id = Plan._id
        Plan._id += 1
        days = []
        self.startDate = startDate
        self.startWeight = startWeight
        self.goal = goalWeight
        self.rate = rate
        self.gender = gender
        self.height = height
        self.age = age
        self.activityLevel = activityLevel
    }
    
    var caloriesPerDay : Float {
        Plan.caloriesPerDay(gender: self.gender, activityLevel: self.activityLevel,
                            age: self.age, startWeight: self.startWeight!, height: self.height, rate: self.rate)
    }
    
    mutating func setGender(to newGender: Bool) -> Void {
        self.gender = newGender
    }
    
    mutating func setHeight(to newHeight: Float) -> Void {
        self.height = newHeight
    }
    
    mutating func setAge(to newAge: Int) -> Void {
        self.age = newAge
    }
    
    mutating func setActivityLevel(to newLevel: Int) -> Void {
        self.activityLevel = newLevel
    }
    
    mutating func setStartDate(to newStartDate: Date) -> Void {
        self.startDate = newStartDate
    }
    
    mutating func setStartWeight(to newStartWeight: Float) -> Void {
        self.startWeight = newStartWeight
    }
    
    mutating func setGoalWeight(to newGoalWeight: Float) -> Void {
        self.goal = newGoalWeight
    }
    
    mutating func setRate(to newRate: Float) -> Void {
        self.rate = newRate
    }
    
    static func caloriesPerDay(gender: Bool, activityLevel: Int, age: Int, startWeight: Float, height: Float, rate: Float) -> Float {
        // Total Energy Expenditure
        var bmr: Float
        if gender {
            // Male
            bmr = 66 + 6.2 * Float(startWeight) + 12.7 * Float(height)
                - 6.76 * Float(age)
        } else {
            // Female
            bmr = 655.1 + 4.35 * Float(startWeight) + 4.7 * Float(height)
                - 4.7 * Float(age)
        }
        let activityLevelMultipliers: [Float] = [1.2, 1.375, 1.55, 1.725]
        // Total Daily Energy Expenditure
        let tdee = bmr * activityLevelMultipliers[activityLevel]
        let extraCalorie = rate * 500
        return tdee - extraCalorie
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
        var day = newDay
        day.setBudgetCalories(to: self.caloriesPerDay)
        if hasRecord(on: day.date) {
            removeDay(on: day.date)
        }
        days.append(day)
        if days.count == 1 {
            startWeight = day.weight ?? nil
        }
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
    
    func weeklyAverageCalories(withRespectTo date: Date) -> Int {
        weekdaysCalories(withRespectTo: date) / 7
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
    
    func weeklyAverageNutrients(withRespectTo date: Date) -> Nutrient {
        let totalNutrient = weekdaysNutrients(withRespectTo: date)
        let averageNutrient = Nutrient(fat: totalNutrient.fat / 7,
                                       satFat: totalNutrient.satFat / 7,
                                       cholesterol: totalNutrient.cholesterol / 7,
                                       sodium: totalNutrient.sodium / 7,
                                       carbs: totalNutrient.carbs / 7,
                                       fiber: totalNutrient.fiber / 7,
                                       sugars: totalNutrient.sugars / 7,
                                       protein: totalNutrient.protein / 7)
        return averageNutrient
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
    
    func weights() -> [Date: Float] {
        var weightPairs: [Date: Float] = [:]
        for day in self.days {
            if day.hasWeight() {
                weightPairs[day.date] = day.weight!
            }
        }
        return weightPairs
    }
    
    func orderedWeights() -> [(Date, Float)] {
        var resList: [(Date, Float)] = []
        let weights = self.weights()
        for date in weights.keys.sorted() {
            resList.append((date, weights[date]!))
        }
        return resList
    }
    
    func latestWeight() -> Float {
        let weights = self.weights()
        let sortedDates = weights.keys.sorted()
        if let lastDate = sortedDates.last {
            return weights[lastDate] ?? 0
        } else {
            return 0
        }
    }
    
    mutating func updateWeight(date: Date, weight: Float) -> Void {
        if hasRecord(on: date) {
            var record = dayRecord(on: date)!
            record.setWeight(to: weight)
            addDay(newDay: record)
        }
    }
    
    static func rateDescription(rate: Float) -> String {
        if rate == 0 {
            return "Maintain current weight"
        } else if rate == 0.5 || rate == 1.5 {
            return "Lose \(Int(rate)).5 lbs per week"
        } else if rate == 1.0 {
            return "Lose 1 lb per week"
        } else {
            return "Lose \(Int(rate)) lbs per week"
        }
    }
    
    func isWeightDecreasing() -> Bool {
        if let weight = startWeight {
            return latestWeight() <= weight
        } else {
            return false
        }
    }
    
    func weightDifference() -> Float {
        if let weight = startWeight {
            return abs(latestWeight() - weight)
        } else {
            return 0
        }
    }
    
    func weightDifferencePercenage() -> Int {
        if let start = startWeight, start != goal {
            return Int((start - latestWeight()) / (start - goal) * 100)
        } else {
            return 0
        }
    }
    
    func expectedDaysLeft() -> Int {
        if rate == 0 {
            return 0
        } else if latestWeight() <= goal {
            return 0
        } else {
            let weightLeft = latestWeight() - goal
            let weeksLeft = weightLeft / rate
            return Int(weeksLeft * 7)
        }
    }
    
    func expectedDate() -> Date {
        let daysLeft = expectedDaysLeft()
        return Date(timeIntervalSinceNow: Double(60*60*24*daysLeft))
    }
    
    func expectedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d YYYY"
        return formatter.string(from: expectedDate())
    }
    
    static func activityLevelDescription(activityLevel: Int) -> String {
        if activityLevel == 0 {
            return "Not Active"
        } else if activityLevel == 1 {
            return "Lightly Active"
        } else if activityLevel == 2 {
            return "Moderately Active"
        } else {
            return "Very Active"
        }
    }
    static func activityLevelLongDescription(activityLevel: Int) -> String {
        if activityLevel == 0 {
            return "Never or rarely include phsical activity in your day"
        } else if activityLevel == 1 {
            return "Include light activity or moderate activity about two to three times a week"
        } else if activityLevel == 2 {
            return "Include at least 30 minutes of moderate activity most days of the week, or 20 minutes of vigorous activity at least three days a week"
        } else {
            return "Include large amounts of moderate or vigorous activity in your day"
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
