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
    
    func setDuration(to newDuration: Int, exerciseList: ExerciseList, dayLog: DayLog) -> Void {
        workout.setDuration(to: newDuration)
        exerciseList.setWorkout(workout: workout)
        dayLog.setExercise(exercise: exerciseList.getExercise())
    }
    
    func setDuration(newHour: Int, newMinute: Int, exerciseList: ExerciseList, dayLog: DayLog) -> Void {
        setDuration(to: newHour * 60 + newMinute, exerciseList: exerciseList, dayLog: dayLog)
    }
    
    func setExcluded(to newExcluded: Bool, exerciseList: ExerciseList, dayLog: DayLog) -> Void {
        if newExcluded != workout.excluded {
            workout.setExcluded(to: newExcluded)
            exerciseList.setWorkout(workout: workout)
            dayLog.setExercise(exercise: exerciseList.getExercise())
        }
    }
    
    func saveWorkout(to exerciseList: ExerciseList, dayLog: DayLog) -> Void {
        exerciseList.setWorkout(workout: workout)
        dayLog.setExercise(exercise: exerciseList.getExercise())
        objectWillChange.send()
    }
}
