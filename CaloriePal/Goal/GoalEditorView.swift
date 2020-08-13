//
//  GoalEditorView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/12/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct GoalEditorView: View {
    @EnvironmentObject var rootStore: RootStore
    @ObservedObject var goalEditor: GoalEditor
    @State var gender: Bool
    @State var age: String
    @State var heightFeet: String
    @State var heightInch: String
    @State var weightUpdatePresented: Bool = false
    @State var activityLevel: Double
    @State var rate: Float

    init(goalEditor: GoalEditor) {
        self.goalEditor = goalEditor
        self._gender = State(initialValue: goalEditor.plan.gender)
        self._age = State(initialValue: String(goalEditor.plan.age))
        self._heightFeet = State(initialValue: String(Int(goalEditor.plan.height) / 12))
        self._heightInch = State(initialValue: String(Int(goalEditor.plan.height) % 12))
        self._activityLevel = State(initialValue: Double(goalEditor.plan.activityLevel))
        self._rate = State(initialValue: goalEditor.plan.rate)
    }
    
    var body: some View {
            Form {
                Section(header: Text("ABOUT YOU")) {
                    Picker(selection: self.$gender, label: Text("Gender")) {
                        Text("Male").tag(true)
                        Text("Female").tag(false)
                    }
                    ZStack(alignment: .trailing) {
                        Picker(selection: .constant("Age"), label: Text("Age")) {
                            TextField("Age", text: self.$age)
                                .keyboardType(.numberPad)
                                .tag(self.age)
                        }
                        Text(self.age)
                            .foregroundColor(Color.gray)
                            .padding(.trailing)
                    }
                    
                    ZStack(alignment: .trailing) {
                        Picker(selection: .constant("Height"), label: Text("Height")) {
                            HStack {
                                TextField("Feet", text: self.$heightFeet)
                                    .keyboardType(.numberPad)
                                    .tag("Feet")
                                    .frame(minWidth: 200)
                                Spacer()
                                Text("Feet")
                            }
                            HStack {
                                TextField("Inch", text: self.$heightInch)
                                    .keyboardType(.numberPad)
                                    .tag("Inch")
                                    .frame(minWidth: 200)
                                Spacer()
                                Text("Inch")
                            }
                        }
                        Text("\(self.heightFeet) ft \(self.heightInch) in")
                            .foregroundColor(Color.gray)
                            .padding(.trailing)
                    }
                }
                
                Section(header: Text("HEALTH PROFILE"), footer:
                    HStack(alignment: .top) {
                        Image(systemName: "questionmark.circle")
                            .imageScale(.large)
                        Text(Plan.activityLevelLongDescription(activityLevel: Int(self.activityLevel)))
                    }
                ) {
                    HStack {
                        Text("Current Weight")
                        Spacer()
                        Text("\(Int(self.rootStore.plan.latestWeight())) lbs")
                            .foregroundColor(Color.gray)
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .foregroundColor(Color.gray)
                    }.onTapGesture {
                        self.weightUpdatePresented = true
                    } .sheet(isPresented: self.$weightUpdatePresented) {
                        WeightUpdateView(goalViewModel: GoalViewModel(), isPresented: self.$weightUpdatePresented,
                                     weightNumber: self.rootStore.getToday().weight ?? 0)
                        .environmentObject(self.rootStore)
                    }
                    
                    VStack {
                        HStack {
                            Text("Activity Level")
                            Spacer()
                            Text("\(Plan.activityLevelDescription(activityLevel: Int(self.activityLevel)))")
                        }
                        Slider(value: self.$activityLevel, in: 0...3, step: 1)
                    }
                }
                
                Section(header: Text("MY CALORIE BUDGET"), footer: Text("Your daily calorie budget is calculated based on your age, gender, height, current weight, and physical activity level. It is intended to produce the energy deficit required to meet your weight loss rate and will change as your weight changes.")) {
                    HStack {
                        Text("Weight Loss Rate")
                        Spacer()
                        Text("\(Plan.rateDescription(rate: self.rate))")
                    }
                    Slider(value: self.$rate, in: 0...2, step: 0.5)
                    HStack(alignment: .bottom) {
                        Text(String(Int(
                            Plan.caloriesPerDay(gender: self.gender, activityLevel: Int(self.activityLevel), age: Int(self.age)!, startWeight: self.rootStore.plan.startWeight!, height: Float(self.heightFeet)! * Float(12) + Float(self.heightInch)!, rate: self.rate)
                        )))
                        Text("calories per day")
                            .fontWeight(.semibold)
                    }
                }
            }
        .navigationBarTitle("Weight Loss Plan", displayMode: .inline)

        
    }
}

struct GoalEditorView_Previews: PreviewProvider {
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
        
        return GoalEditorView(goalEditor: GoalEditor(plan: plan))
            .environmentObject(RootStore(plan: plan))
    }
}
