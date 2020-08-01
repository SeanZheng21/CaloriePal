//
//  DayLogView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct DayLogView: View {
    @ObservedObject var dayLog: DayLog
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                MealListView(mealList: MealList(meal: dayLog.breakfast))
                Divider()
                MealListView(mealList: MealList(meal: dayLog.lunch))
                Divider()
                MealListView(mealList: MealList(meal: dayLog.dinner))
                Divider()
                MealListView(mealList: MealList(meal: dayLog.snacks))
                Divider()
                ExerciseListView(exerciseList: ExerciseList(exercise: dayLog.exercise!))
                Spacer()
            }
            .navigationBarTitle("\(dayLog.dateString)", displayMode: .inline)
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct DayLogView_Previews: PreviewProvider {
    static var previews: some View {
        let breakfast = Meal(id: 1, type: .breakfast, foods: [foodData[0], foodData[1]])
        let lunch = Meal(id: 1, type: .lunch, foods: [foodData[1], foodData[2]])
        let dinner = Meal(id: 1, type: .dinner, foods: [foodData[2], foodData[3]])
        let snacks = Meal(id: 1, type: .snacks, foods: [foodData[2]])
        let exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
        let dayLog = DayLog(day: Day(breakfast: breakfast, lunch: lunch, dinner: dinner, snacks: snacks, exercise: exercise))
        
        return DayLogView(dayLog: dayLog)
    }
}
