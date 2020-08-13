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
                    HStack {
                        Text(Plan.rateDescription(rate: self.rootStore.plan.rate))
                            .font(.title)
                            .fontWeight(.semibold)
                        Spacer()
                        NavigationLink(destination:
                            GoalEditorView(goalEditor: GoalEditor(plan: self.rootStore.plan))
                                .environmentObject(self.rootStore)
                        ) {
                            Text("Change")
                        }
                    }
                        .padding(.all)
                    
                    WeightChartView(rootStore: self.rootStore)
                        .frame(width: geometry.size.width, height: GoalView.chartHeight)
                        .border(Color.black)
                    
                    HStack(alignment: .center) {
                        Text("LAST RECORDED WEIGHT:")
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Spacer(minLength: 0)

                        Text(String(Int(self.rootStore.plan.latestWeight())))
                            .fontWeight(.bold)
                            .font(.system(size: 33))
                        Text("lbs")
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                    }
                    .padding(.horizontal)
                    
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
                            WeightUpdateView(goalViewModel: self.goalViewModel, isPresented: self.$showWeightUpdate, weightNumber: self.rootStore.getToday().weight ?? 0)
                                .environmentObject(self.rootStore)
                        }
                        .padding()

                    HStack(alignment: .center, spacing: 5) {
                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Text("So far  ")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                Image(systemName: "arrow.\(self.rootStore.plan.isWeightDecreasing() ? "down" : "up").circle.fill")
                                    .imageScale(.large)

                                Text(String(Int(self.rootStore.plan.weightDifference())))
                                    .fontWeight(.semibold)
                                    .font(.system(size: 33))
                                Text(" lbs")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.gray)
                            }
                            Text("\(Int(self.rootStore.plan.latestWeight() - self.rootStore.plan.goal)) lbs to goal")
                                .fontWeight(.bold)
                        }
                        
                        Spacer(minLength: 0)
                        VStack(alignment: .center) {
                            CircularProgressBar(progress: Float(self.rootStore.plan.weightDifferencePercenage())/100, color: self.rootStore.plan.isWeightDecreasing() ? .green : .orange)
                                .frame(width: GoalView.progressBarHeight, height: GoalView.progressBarHeight)
                            Text("completed")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray)
                        }
                            .padding(.trailing)

                    }
                        .padding(.horizontal)
                    Text("Based on your current plan, you'll reach your goal on")
                        .font(.callout)
                        .padding(.top)
                    HStack {
                        Text(self.rootStore.plan.expectedDateString())
                            .fontWeight(.bold)
                            .underline()
                        Text(" in \(self.rootStore.plan.expectedDaysLeft()) days")
                    }
                
                }
                .frame(width: geometry.size.width)
                .navigationBarTitle("Weight Loss Goals", displayMode: .inline)
            }
        }
    }
    
    private static let chartHeight: CGFloat = 350
    private static let progressBarHeight: CGFloat = 150
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        let breakfast = Meal(id: 1, type: .breakfast, foods: [foodData[0]])
        let lunch = Meal(id: 1, type: .lunch, foods: [foodData[1]])
        let dinner = Meal(id: 1, type: .dinner, foods: [foodData[3]])
        let snacks = Meal(id: 1, type: .snacks, foods: [foodData[2]])
        let exercise = Exercise(id: 1, workouts: [workoutData[0]])
        let day1 = Day(date: Date(), breakfast: breakfast, lunch: lunch, dinner: dinner, snacks: snacks, exercise: exercise, weight: 155)
        
        let breakfast1 = Meal(id: 1, type: .breakfast, foods: [foodData[1]])
        let lunch1 = Meal(id: 1, type: .lunch, foods: [])
        var food = foodData[2]
        food.setAmount(to: 7)
        let dinner1 = Meal(id: 1, type: .dinner, foods: [food])
        let snacks1 = Meal(id: 1, type: .snacks, foods: [])
        let exercise1 = Exercise(id: 1, workouts: [workoutData[1]])
        let day2 = Day(date: Date(timeIntervalSinceNow: -60*60*24), breakfast: breakfast1, lunch: lunch1, dinner: dinner1, snacks: snacks1,
                      exercise: exercise1)
        let day3 = Day(date: Date(timeIntervalSinceNow: -60*60*24*2), breakfast: breakfast, weight: 157)

        var plan = Plan(gender: true, height: 73, age: 23, activityLevel: 1, from: Date(), startWeight: 157, goalWeight: 150, rate: 1.5)
        plan.addDay(newDay: day3)
        plan.addDay(newDay: day2)
        plan.addDay(newDay: day1)
        return GoalView(rootStore: RootStore(plan: plan), goalViewModel: GoalViewModel())
    }
}
