//
//  RootTabView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/3/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct RootTabView: View {
    @ObservedObject var rootStore: RootStore
    
    var body: some View {
        TabView() {
            StatisticsView(rootStore: self.rootStore)
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                        .imageScale(.large)
                    Text("Statistics")
                }
                .tag(1)
            DayLogView(rootStore: rootStore,
                       dayLog: DayLog(day:
                        rootStore.getDay(on: self.rootStore.lastAccessedDate) ?? Day()))
                .tabItem {
                        VStack {
                            Image(systemName: "sun.haze.fill")
                            Text("Day")
                        }
                }
                .tag(2)
            AdderView(rootStore: rootStore)
                .tabItem {
                    Image(systemName: "plus.app.fill")
                        .imageScale(.large)
                    Text("Add")
                }
                .tag(3)
            GoalView(rootStore: self.rootStore, goalViewModel: GoalViewModel())
                .tabItem {
                    Image(systemName: "waveform.path.ecg")
                        .imageScale(.large)
                    Text("Goal")
                }
                .tag(4)
            NavigationView {
                GoalEditorView(goalEditor: GoalEditor(plan: self.rootStore.plan))
                    .environmentObject(self.rootStore)
            }
                .tabItem {
                    Image(systemName: "gear")
                        .imageScale(.large)
                    Text("Settings")
                }
                .tag(5)
        }
    }
}

struct RootTabView_Previews: PreviewProvider {
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

        var plan = Plan(gender: true, height: 73, age: 23, activityLevel: 1, from: Date(), startWeight: 157, goalWeight: 155, rate: 1.0)
        plan.addDay(newDay: day1)
        plan.addDay(newDay: day2)
        plan.addDay(newDay: day3)
        return RootTabView(rootStore: RootStore(plan: plan))
    }
}
