//
//  WeightChartView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/11/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct WeightChartView: View {
    @ObservedObject var rootStore: RootStore
    
    var body: some View {
        VStack {
            ForEach(self.rootStore.plan.days, id: \.self) { day in
                Text("\(day.dateString()) - \( day.hasWeight() ? String(Int(day.weight!)) : "No Record")")
            }
        }
    }
}

struct WeightChartView_Previews: PreviewProvider {
    static var previews: some View {
        let breakfast = Meal(id: 1, type: .breakfast, foods: [foodData[0]])
        let lunch = Meal(id: 1, type: .lunch, foods: [foodData[1]])
        let dinner = Meal(id: 1, type: .dinner, foods: [foodData[3]])
        let snacks = Meal(id: 1, type: .snacks, foods: [foodData[2]])
        let exercise = Exercise(id: 1, workouts: [workoutData[0]])
        let day1 = Day(date: Date(), breakfast: breakfast, lunch: lunch, dinner: dinner, snacks: snacks, exercise: exercise, weight: 157)
        
        let breakfast1 = Meal(id: 1, type: .breakfast, foods: [foodData[1]])
        let lunch1 = Meal(id: 1, type: .lunch, foods: [])
        var food = foodData[2]
        food.setAmount(to: 7)
        let dinner1 = Meal(id: 1, type: .dinner, foods: [food])
        let snacks1 = Meal(id: 1, type: .snacks, foods: [])
        let exercise1 = Exercise(id: 1, workouts: [workoutData[1]])
        let day2 = Day(date: Date(timeIntervalSinceNow: -60*60*24), breakfast: breakfast1, lunch: lunch1, dinner: dinner1, snacks: snacks1,
                      exercise: exercise1)
        let day3 = Day(date: Date(timeIntervalSinceNow: -60*60*24*2), breakfast: breakfast, weight: 155)

        var plan = Plan(gender: true, height: 73, age: 23, from: Date(), startWeight: 157, goalWeight: 155, rate: 1.0)
        plan.addDay(newDay: day1)
        plan.addDay(newDay: day2)
        plan.addDay(newDay: day3)
        return WeightChartView(rootStore: RootStore(plan: plan))
    }
}
