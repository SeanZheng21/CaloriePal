//
//  StatisticsNutrientWeeklyView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/8/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct StatisticsNutrientWeeklyView: View {
    @ObservedObject var rootStore: RootStore
    @State var day: Day
    
    init(rootStore: RootStore, day: Day) {
        self._day = State(initialValue: day)
        self.rootStore = rootStore
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            BarChartView(data: convertNutrients(from: rootStore.plan),
                     tags: ["S", "M", "Tu", "W", "Th", "F", "Sa"],
                     colors: [Nutrient.fatColor, Nutrient.carbColor, Nutrient.proteinColor])
                .padding(.vertical)
                .frame(height: StatisticsNutrientWeeklyView.barChartHeight)
            Text("DAILY AVERAGES")
                .fontWeight(.semibold)
                .foregroundColor(Color.gray)
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.fatColor)
                            .imageScale(.medium)
                        Text("Fat - \(Int(fatPercentage(totalNutrient: self.averageNutrient)))%")
                        Spacer()
                        Text(Nutrient.formatNutrient(self.averageNutrient.fat) + "g")
                    }
                    HStack {
                        Text("          Saturated Fat")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text(Nutrient.formatNutrient(self.averageNutrient.satFat) + "g")
                    }
                    HStack {
                        Text("    Cholesterol")
                        Spacer()
                        Text(Nutrient.formatNutrient(self.averageNutrient.cholesterol) + "mg")
                    }
                    HStack {
                        Text("    Sodium")
                        Spacer()
                        Text(Nutrient.formatNutrient(self.averageNutrient.sodium) + "mg")
                    }
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.carbColor)
                            .imageScale(.medium)
                        Text("Carbonhydrates - \(Int(carbsPercentage(totalNutrient: self.averageNutrient)))%")
                        Spacer()
                        Text(Nutrient.formatNutrient(self.averageNutrient.carbs) + "g")
                    }
                    HStack {
                        Text("          Fiber")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text(Nutrient.formatNutrient(self.averageNutrient.fiber) + "g")
                    }
                    HStack {
                        Text("          Sugars")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text(Nutrient.formatNutrient(self.averageNutrient.sugars) + "g")
                    }
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.proteinColor)
                            .imageScale(.medium)
                        Text("Protein - \(Int(proteinPercentage(totalNutrient: self.averageNutrient)))%")
                        Spacer()
                        Text(Nutrient.formatNutrient(self.averageNutrient.protein) + "g")
                    }
                }
            }
            .padding(.vertical)
            Spacer()
        }
        .padding(.horizontal)
            .navigationBarTitle("Weekly Nutrient Detail")
    }
    
    var averageNutrient: Nutrient {
        self.rootStore.plan.weeklyAverageNutrients(withRespectTo: self.day.date)
    }
    
    private func convertNutrients(from plan: Plan) -> [[Float]] {
        var nutrients: [[Float]] = [[], [], [], [], [], [], []]
        let days = plan.weekdaysInWeek(withRespectTo: Date())
        let dates = Date().weekdaysInWeek()
        for day in days {
            let idx = dates.firstIndex(where: {$0.onSameDay(otherDate: day.date)})
            let percentageMultiplier = min(Float(day.totalCalories()) / plan.caloriesPerDay, 1.0)
            nutrients[idx!] = [Float(fatPercentage(totalNutrient: day.totalNutrients())) * percentageMultiplier/100,
                                Float(carbsPercentage(totalNutrient: day.totalNutrients())) * percentageMultiplier/100,
                                Float(proteinPercentage(totalNutrient: day.totalNutrients())) * percentageMultiplier/100]
        }
        return nutrients
    }
    
    var totalNutrients: Nutrient {
        self.day.totalNutrients()
    }
    
    func fatPercentage(totalNutrient: Nutrient)-> Int {
        let totalPercentageCalc = totalNutrient.fatPercentage() +
                                    totalNutrient.carbsPercentage() +
                                    totalNutrient.proteinPercentage()
        return Int(totalNutrient.fatPercentage() / totalPercentageCalc * 100)
    }
    
    func carbsPercentage(totalNutrient: Nutrient)-> Int {
        let totalPercentageCalc = totalNutrient.fatPercentage() +
                                    totalNutrient.carbsPercentage() +
                                    totalNutrient.proteinPercentage()
        return Int(totalNutrient.carbsPercentage() / totalPercentageCalc * 100)
    }
    
    func proteinPercentage(totalNutrient: Nutrient)-> Int {
        let totalPercentageCalc = totalNutrient.fatPercentage() +
                                    totalNutrient.carbsPercentage() +
                                    totalNutrient.proteinPercentage()
        return Int(totalNutrient.proteinPercentage() / totalPercentageCalc * 100)
    }
    
    private static var barChartHeight: CGFloat = 200
}

struct StatisticsNutrientWeeklyView_Previews: PreviewProvider {
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

        var plan = Plan(gender: true, height: 73, age: 23, from: Date(), startWeight: 157, goalWeight: 155, rate: 1.0)
        plan.addDay(newDay: day1)
        plan.addDay(newDay: day2)
        plan.addDay(newDay: day3)
        let rootStore = RootStore(plan: plan)
        return StatisticsNutrientWeeklyView(rootStore: rootStore, day: rootStore.getToday())
    }
}
