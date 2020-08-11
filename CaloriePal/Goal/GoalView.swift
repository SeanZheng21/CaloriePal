//
//  GoalView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/11/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct GoalView: View {
    @ObservedObject var rootStore: RootStore
    @ObservedObject var goalViewModel: GoalViewModel
    @State var showWeightUpdate = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView() {
                    WeightChartView(rootStore: self.rootStore)
                        .frame(width: geometry.size.width, height: GoalView.chartHeight)
                        .border(Color.black)
                    
                    Button(action: {
                        self.showWeightUpdate = true
                    }) {
                        Text("Update Your Weight")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                        .overlay(RoundedRectangle(cornerRadius: 40)
                            .stroke(Color.blue, lineWidth: 5))
                    }
                        .sheet(isPresented: self.$showWeightUpdate) {
                            WeightUpdateView(goalViewModel: self.goalViewModel, isPresented: self.$showWeightUpdate)
                                .environmentObject(self.rootStore)
                        }
                        .padding()

                }
                .frame(width: geometry.size.width)
                .navigationBarTitle("Weight Loss Goals", displayMode: .inline)
            }
        }
    }
    
    private static let chartHeight: CGFloat = 350
}

struct GoalView_Previews: PreviewProvider {
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

        var plan = Plan(from: Date(), startWeight: 157, goalWeight: 155, rate: 1.0)
        plan.addDay(newDay: day1)
        plan.addDay(newDay: day2)
        plan.addDay(newDay: day3)
        return GoalView(rootStore: RootStore(plan: plan), goalViewModel: GoalViewModel())
    }
}
