//
//  StatisticsNutrientDetailView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/8/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct StatisticsNutrientDetailView: View {
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
                .padding(.top)
            Divider()
            HStack {
                Spacer(minLength: 0.0)
                PieChartView(pieChartData:
                    pieChartData(totalNutrient: self.day.totalNutrients()))
                    .frame(width: StatisticsNutrientDetailView.chartSideLength,
                           height: StatisticsNutrientDetailView.chartSideLength,
                           alignment: .center)
                Spacer(minLength: 0.0)
            }
                .padding(.top)
//            Divider()
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.fatColor)
                            .imageScale(.medium)
                        Text("Fat - \(Int(fatPercentage(totalNutrient: self.day.totalNutrients())))%")
                        Spacer()
                        Text(Nutrient.formatNutrient(self.day.totalNutrients().fat) + "g")
                    }
                    HStack {
                        Text("          Saturated Fat")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text(Nutrient.formatNutrient(self.day.totalNutrients().satFat) + "g")
                    }
                    HStack {
                        Text("    Cholesterol")
                        Spacer()
                        Text(Nutrient.formatNutrient(self.day.totalNutrients().cholesterol) + "mg")
                    }
                    HStack {
                        Text("    Sodium")
                        Spacer()
                        Text(Nutrient.formatNutrient(self.day.totalNutrients().sodium) + "mg")
                    }
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.carbColor)
                            .imageScale(.medium)
                        Text("Carbonhydrates - \(Int(carbsPercentage(totalNutrient: self.day.totalNutrients())))%")
                        Spacer()
                        Text(Nutrient.formatNutrient(self.day.totalNutrients().carbs) + "g")
                    }
                    HStack {
                        Text("          Fiber")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text(Nutrient.formatNutrient(self.day.totalNutrients().fiber) + "g")
                    }
                    HStack {
                        Text("          Sugars")
                            .foregroundColor(Color.gray)
                        Spacer()
                        Text(Nutrient.formatNutrient(self.day.totalNutrients().sugars) + "g")
                    }
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.proteinColor)
                            .imageScale(.medium)
                        Text("Protein - \(Int(proteinPercentage(totalNutrient: self.day.totalNutrients())))%")
                        Spacer()
                        Text(Nutrient.formatNutrient(self.day.totalNutrients().protein) + "g")
                    }
                }
            }
            .padding(.all)
            Spacer()
        }
            .navigationBarTitle("Daily Nutrient Detail")
    }
    
    func pieChartData(totalNutrient: Nutrient) -> PieChartData {

        return PieChartData(data: [
            Double(totalNutrient.fatPercentage()),
            Double(totalNutrient.carbsPercentage()),
            Double(totalNutrient.proteinPercentage())
        ], colors: [
            Nutrient.fatColor,
            Nutrient.carbColor,
            Nutrient.proteinColor
        ])
    }
    
    var totalNutrients: Nutrient {
        rootStore.getDay(on: Date())!.totalNutrients()
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
    
    private static var chartSideLength: CGFloat = 220
    private static var barChartHeight: CGFloat = 100
}

struct StatisticsNutrientDetailView_Previews: PreviewProvider {
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
        let rootStore = RootStore(plan: plan)
        return StatisticsNutrientDetailView(rootStore: rootStore, day: rootStore.getToday())
    }
}
