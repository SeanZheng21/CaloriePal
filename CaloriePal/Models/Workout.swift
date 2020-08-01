//
//  Workout.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/1/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

struct Workout: Hashable, Codable, Identifiable {
    var id: Int
    private(set) var name: String
    private(set) var caloriePerMinute: Int
    private(set) var duration: Int
    private(set) var excluded: Bool
    
    var calories: Int {
        caloriePerMinute * duration
    }
    
    mutating func setDuration(to newDuration: Int) -> Void {
        duration = newDuration
    }
    
    mutating func setExcluded(to excluded: Bool) -> Void {
        self.excluded = excluded
    }
    
    var durationHour: Int {
        duration / 60
    }
    
    var durationMinute: Int {
        duration % 60
    }
    
    func durationDescription() -> String {
        if duration < 60 {
            return "\(duration) Min"
        } else {
            return "\(durationHour) Hr \(durationMinute) Min"
        }
    }
    
    func toJsonString() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}
