//
//  StatisticsCalorieDetailView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/8/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct StatisticsCalorieDetailView: View {
    @ObservedObject var rootStore: RootStore
    @State var day: Day
    
    init(rootStore: RootStore, day: Day) {
        self._day = State(initialValue: day)
        self.rootStore = rootStore
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.day = self.rootStore.plan.previousDay(withRespectTo: self.day)
                }) {
                    Image(systemName: "chevron.left.circle")
                        .foregroundColor(Color.blue)
                        .imageScale(.medium)
                }
                Text("\(self.day.dateString())")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Button(action: {
                    self.day = self.rootStore.plan.followingDay(withRespectTo: self.day)
                }) {
                    Image(systemName: "chevron.right.circle")
                        .foregroundColor(Color.blue)
                        .imageScale(.medium)
                }
                Spacer()
            }
            .padding(.horizontal)
            Divider()
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading) {
                    Text("Budget:")
                        .font(.system(size: 23))
                        .foregroundColor(Color.gray)
                    Text("\(Int(self.rootStore.plan.caloriesPerDay)) cal")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                    Spacer().frame(height: 7)
                    Text("Net:")
                        .font(.system(size: 23))
                        .foregroundColor(Color.gray)
                    Text("\(Int(self.day.totalCalories())) cal")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                    Spacer().frame(height: 7)
                    Text("\(abs(Int(self.rootStore.plan.caloriesPerDay) - self.day.totalCalories())) cal")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("\(Int(self.rootStore.plan.caloriesPerDay) > self.day.totalCalories() ? "under" : "over") budget")
                    .foregroundColor(Int(self.rootStore.plan.caloriesPerDay) > self.day.totalCalories() ? .green : .orange)
                        .font(.title)
                        .fontWeight(.bold)
                }
                Spacer(minLength: 0)
                CircularProgressBar(
                    progress: self.pieChartPercentages,
                    color: self.isUnderBudget ? .green : .orange)
                    .frame(width: 200, height: 200)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Food calories consumed")
                    Spacer()
                    Text("\(self.day.foodCalories())")
                }
                HStack {
                    Text("Exercise calories burned")
                    Spacer()
                    Text("\(self.day.exerciseCalories())")
                }
                Divider()
                    .foregroundColor(.black)
                HStack {
                    Text("Net calories")
                    Spacer()
                    Text("\(self.day.totalCalories())")
                }
            }
            .padding()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Daily calorie budget")
                    Spacer()
                    Text("\(Int(self.rootStore.plan.caloriesPerDay))")
                }
                HStack {
                    Text("Net calories")
                    Spacer()
                    Text("\(self.day.totalCalories())")
                }
                Divider()
                    .foregroundColor(.black)
                HStack {
                    Text("Calories \(Int(self.rootStore.plan.caloriesPerDay) > self.rootStore.getToday().totalCalories() ? "under" : "over") budget")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("\(abs(Int(self.rootStore.plan.caloriesPerDay) - self.rootStore.getToday().totalCalories()))")
                        .foregroundColor(Int(self.rootStore.plan.caloriesPerDay) > self.rootStore.getToday().totalCalories() ? .green : .orange)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            Spacer()
        }
        .padding(.vertical)
        .navigationBarTitle("Daily Calorie Detail")
    }
    
    var pieChartPercentages: Float {
        let percentage = Float(self.rootStore.getToday().totalCalories())/Float(self.rootStore.plan.caloriesPerDay)
        if percentage < 1 {
            return percentage
        } else {
            return percentage - Float(Int(percentage))
        }
    }
    
    var isUnderBudget: Bool {
        Int(self.rootStore.plan.caloriesPerDay) > self.day.totalCalories()
    }
}

struct StatisticsCalorieDetailView_Previews: PreviewProvider {
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

        var plan = Plan(from: Date(), startWeight: 157, goalWeight: 155, rate: 1.0)
        plan.addDay(newDay: day1)
        plan.addDay(newDay: day2)
        plan.addDay(newDay: day3)
        let rootStore = RootStore(plan: plan)
        return StatisticsCalorieDetailView(rootStore: rootStore, day: rootStore.getToday())
    }
}
