//
//  WorkoutDetail.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/1/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class WorkoutDetail: ObservableObject {
    @Published private var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    var workoutName: String {
        workout.name
    }
    
    var workoutCalories: Int {
        workout.calories
    }
    
    var workoutDuration: Int {
        workout.duration
    }
    
    var workoutExcluded: Bool {
        workout.excluded
    }
    
    var workoutHour: Int {
        workout.durationHour
    }
    
    var workoutMinute: Int {
        workout.durationMinute
    }
    
    func setDuration(to newDuration: Int) -> Void {
        workout.setDuration(to: newDuration)
    }
    
    func setDuration(newHour: Int, newMinute: Int) -> Void {
        workout.setDuration(to: newHour * 60 + newMinute)
    }
    
    func setExcluded(to newExcluded: Bool) -> Void {
        if newExcluded != workout.excluded {
            workout.setExcluded(to: newExcluded)
        }
    }
}
