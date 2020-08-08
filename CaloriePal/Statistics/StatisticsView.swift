//
//  StatisticsView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/6/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var rootStore: RootStore
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView() {
                    VStack(alignment: .leading, spacing: 0.0) {
                        HStack {
                            Text("Calories Summary")
                                .font(.title)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        StatisticsCalorieView(rootStore: self.rootStore)
                            .frame(height: StatisticsView.calorieSummaryHeight)
//                            .background(Color.red)
                        HStack {
                            Text("Nutrients Summary")
                                .font(.title)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                            .padding([.top, .leading, .trailing])
                        StatisticsNutrientView(rootStore: self.rootStore)
                    }
                        .frame(width: geometry.size.width)
                }.navigationBarTitle("Statistics", displayMode: .inline)
            }
        }
    }
    
    static private var calorieSummaryHeight: CGFloat = 540
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        let breakfast = Meal(id: 1, type: .breakfast, foods: [foodData[0]])
        let lunch = Meal(id: 1, type: .lunch, foods: [foodData[1]])
        let dinner = Meal(id: 1, type: .dinner, foods: [foodData[3]])
        let snacks = Meal(id: 1, type: .snacks, foods: [foodData[2]])
        let exercise = Exercise(id: 1, workouts: [workoutData[0]])
        let day1 = Day(date: Date(), breakfast: breakfast, lunch: lunch, dinner: dinner, snacks: snacks, exercise: exercise)
        
        let breakfast1 = Meal(id: 1, type: .breakfast, foods: [foodData[1]])
        let lunch1 = Meal(id: 1, type: .lunch, foods: [])
        var food = foodData[2]
        food.setAmount(to: 7)
        let dinner1 = Meal(id: 1, type: .dinner, foods: [food])
        let snacks1 = Meal(id: 1, type: .snacks, foods: [])
        let exercise1 = Exercise(id: 1, workouts: [workoutData[1]])
        let day2 = Day(date: Date(timeIntervalSinceNow: -60*60*24), breakfast: breakfast1, lunch: lunch1, dinner: dinner1, snacks: snacks1,
                      exercise: exercise1)
        let day3 = Day(date: Date(timeIntervalSinceNow: -60*60*24*2), breakfast: breakfast)

        var plan = Plan(from: Date(), to: Date(timeIntervalSinceNow: 60*60*24*15), startWeight: 157, goalWeight: 155, rate: 1.0)
        plan.addDay(newDay: day1)
        plan.addDay(newDay: day2)
        plan.addDay(newDay: day3)
        return StatisticsView(rootStore: RootStore(plan: plan))
    }
}
