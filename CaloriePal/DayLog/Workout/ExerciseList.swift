//
//  ExerciseList.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/1/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class ExerciseList: ObservableObject {
    @Published private var exercise: Exercise
    
    init(exercise: Exercise) {
        self.exercise = exercise
    }

    var totalCalories: Int {
        exercise.totalCalories()
    }
    
    func workouts() -> [Workout] {
        exercise.workouts
    }
    
    var exerciseName: String {
        "Exercise"
    }
    
    func getExercise() -> Exercise {
        return exercise
    }
    
    func setWorkout(workout: Workout) -> Void {
        exercise.setWorkout(to: workout)
    }
    
    func addWorkout(newWorkout: Workout) -> Void {
        exercise.addWorkout(newWorkout: newWorkout)
    }
    
    func removeWorkout(workout: Workout) -> Void {
        exercise.removeWorkout(workout: workout)
    }
    
    func getWorkout(of id: Int) -> Workout? {
        return exercise.workouts.first(where: {$0.id == id})
    }
    
    func deleteWorkout(at indexSet: IndexSet, from dayLog: DayLog, store: RootStore) {
        let workoutToDelete = exercise.workouts[indexSet.first!]
        self.removeWorkout(workout: workoutToDelete)
        dayLog.setExercise(exercise: self.exercise, rootStore: store)
        store.saveDay(day: dayLog.day)
        objectWillChange.send()
    }
}
