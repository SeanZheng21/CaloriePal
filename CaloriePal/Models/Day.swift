//
//  Day.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

struct Day: Hashable, Codable, Identifiable {
    var id: Int
    private(set) var date: Date
    private(set) var breakfast: Meal
    private(set) var lunch: Meal
    private(set) var dinner: Meal
    private(set) var snacks: Meal
    private(set) var exercise: Exercise
    
    init(date: Date?=nil, breakfast: Meal?, lunch: Meal?, dinner: Meal?, snacks: Meal?, exercise: Exercise?) {
        if let d = date {
            self.date = d
        } else {
            self.date = Date()
        }
        self.id = Int(self.date.timeIntervalSince1970)
        self.breakfast = breakfast ?? Meal(type: .breakfast)
        self.lunch = lunch ?? Meal(type: .lunch)
        self.dinner = dinner ?? Meal(type: .dinner)
        self.snacks = snacks ?? Meal(type: .snacks)
        self.exercise = exercise ?? Exercise()
    }
    
    func meals() -> [Meal?] {
        [breakfast, lunch, dinner, snacks]
    }
    
    func dateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}
