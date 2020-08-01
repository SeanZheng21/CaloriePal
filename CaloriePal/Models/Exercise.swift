//
//  Exercise.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/1/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation


struct Exercise: Hashable, Codable, Identifiable {
    static private var _id: Int = 20000
    var id: Int
    private(set) var workouts: [Workout]
    
    init(id: Int?=nil, workouts: [Workout]=[]) {
        if id == nil {
            self.id = Exercise._id
            Exercise._id += 1
        } else {
            self.id = id!
        }
        self.workouts = workouts
    }
    
    mutating func addWorkout(newWorkout: Workout) -> Void {
        if let existingIndex = workoutIndex(of: newWorkout) {
            workouts.remove(at: existingIndex)
            workouts.insert(newWorkout, at: existingIndex)
        } else {
            workouts.append(newWorkout)
        }
    }
    
    mutating func removeWorkout(workout: Workout) -> Void {
        if let existingIndex = workoutIndex(of: workout) {
            workouts.remove(at: existingIndex)
        }
    }
    
    mutating func setWorkout(to workout: Workout) -> Void {
        if let existingIndex = workoutIndex(of: workout) {
            workouts.remove(at: existingIndex)
            workouts.insert(workout, at: existingIndex)
        } else {
            addWorkout(newWorkout: workout)
        }
    }
    
    func workoutIndex(of workout: Workout) -> Int? {
        return workouts.firstIndex(where: {$0.id == workout.id})
    }
    
    func hasWorkout(of workout: Workout) -> Bool {
        return workoutIndex(of: workout) != nil
    }
    
    func totalCalories() -> Int {
        var sum = 0
        workouts.forEach({ sum += $0.calories })
        return sum
    }
    
    func totalDuration() -> Int {
        var sum = 0
        workouts.forEach({ sum += $0.duration })
        return sum
    }
}
