//
//  StatisticsCalorieView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/6/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct StatisticsCalorieView: View {
    @ObservedObject var rootStore: RootStore
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer(minLength: 0.0)
                BarChartView(data: StatisticsCalorieView.convertCalories(from: self.rootStore.plan),
                         tags: ["S", "M", "Tu", "W", "Th", "F", "Sa"],
                         colors: [.green])
                    .frame(width: geometry.size.width, height: StatisticsCalorieView.chartHeight)
                Spacer(minLength: 0.0)
            }
                .frame(width: geometry.size.width)
        }
    }
    
    private static func convertCalories(from plan: Plan) -> [[Float]] {
        var calories: [[Float]] = [[], [], [], [], [], [], []]
        let days = plan.weekdaysInWeek(withRespectTo: Date())
        let dates = Date().weekdaysInWeek()
        for day in days {
            let idx = dates.firstIndex(where: {$0.onSameDay(otherDate: day.date)})
            calories[idx!] = [Float(day.totalCalories()) / Float(plan.caloriesPerDay)]
        }
        return calories
    }
    
    private static var chartHeight: CGFloat = 100
}

struct StatisticsCalorieView_Previews: PreviewProvider {
    static var previews: some View {
        let breakfast = Meal(id: 1, type: .breakfast, foods: [foodData[0]])
        let lunch = Meal(id: 1, type: .lunch, foods: [foodData[1]])
        let dinner = Meal(id: 1, type: .dinner, foods: [foodData[3]])
        let snacks = Meal(id: 1, type: .snacks, foods: [foodData[2]])
        let exercise = Exercise(id: 1, workouts: [workoutData[0]])
        let day1 = Day(date: Date(), breakfast: breakfast, lunch: lunch, dinner: dinner, snacks: snacks, exercise: exercise)
        
        let breakfast1 = Meal(id: 1, type: .breakfast, foods: [foodData[1]])
        let lunch1 = Meal(id: 1, type: .lunch, foods: [])
        let dinner1 = Meal(id: 1, type: .dinner, foods: [foodData[2]])
        let snacks1 = Meal(id: 1, type: .snacks, foods: [])
        let exercise1 = Exercise(id: 1, workouts: [workoutData[1]])
        let day2 = Day(date: Date(timeIntervalSinceNow: -60*60*24), breakfast: breakfast1, lunch: lunch1, dinner: dinner1, snacks: snacks1,
                      exercise: exercise1)
        let day3 = Day(date: Date(timeIntervalSinceNow: -60*60*24*2), breakfast: breakfast)

        var plan = Plan(from: Date(), to: Date(timeIntervalSinceNow: 60*60*24*15), startWeight: 157, goalWeight: 155, rate: 1.0)
        plan.addDay(newDay: day1)
        plan.addDay(newDay: day2)
        plan.addDay(newDay: day3)
        return StatisticsCalorieView(rootStore: RootStore(plan: plan))
    }
}
