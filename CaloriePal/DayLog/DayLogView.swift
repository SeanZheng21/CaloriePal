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
    @State var selectedDate = Date()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        DateBannerView(selectedDate: self.$selectedDate)
                            .frame(width: geometry.size.width)
                            .environmentObject(self.dayLog)
                        DayBannerView(dayBanner: DayBanner(day: self.dayLog.day))
                            .frame(width: geometry.size.width, height: DayBannerView.viewHeight)
                        Group {
                            MealListView(mealList: MealList(meal: self.dayLog.breakfast))
                                .environmentObject(self.dayLog)
                            Divider()
                            MealListView(mealList: MealList(meal: self.dayLog.lunch))
                                .environmentObject(self.dayLog)
                            Divider()
                            MealListView(mealList: MealList(meal: self.dayLog.dinner))
                                .environmentObject(self.dayLog)
                            Divider()
                            MealListView(mealList: MealList(meal: self.dayLog.snacks))
                                .environmentObject(self.dayLog)
                            Divider()
                            ExerciseListView(exerciseList: ExerciseList(exercise: self.dayLog.exercise))
                                .environmentObject(self.dayLog)
                        }
                    }
                .navigationBarTitle("\(self.dayLog.dateString)", displayMode: .inline)
                .navigationBarItems(trailing: EditButton())
                }
            }
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
        let day = Day(breakfast: breakfast, lunch: lunch, dinner: dinner, snacks: snacks,
                      exercise: exercise)
        var plan = Plan(from: Date(), to: Date(timeIntervalSinceNow: 60*60*24*15), startWeight: 157, goalWeight: 155, rate: 1.0)
        plan.addDay(newDay: day)
        let dayLog = DayLog(plan: plan)
        
        return DayLogView(dayLog: dayLog)
    }
}
