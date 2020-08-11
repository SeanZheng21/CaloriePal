//
//  StatisticsNutrientView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/8/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct StatisticsNutrientView: View {
    @ObservedObject var rootStore: RootStore

    var body: some View {
        VStack(alignment: .center) {
            NavigationLink(destination:
                StatisticsNutrientDetailView(rootStore: self.rootStore,
                                            day: self.rootStore.getToday())
                ) {
                    HStack {
                        Text("Today")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                            .foregroundColor(Color.blue)
                        Spacer()
                        Text("More")
                            .foregroundColor(Color.blue)
                        Image(systemName: "chevron.right.circle")
                            .foregroundColor(Color.blue)
                            .imageScale(.medium)
                    }
            }
                .padding(.horizontal)
            
            HStack {
                Spacer(minLength: 0.0)
                PieChartView(pieChartData:
                    pieChartData(totalNutrient: totalNutrients))
                    .frame(width: StatisticsNutrientView.chartSideLength,
                           height: StatisticsNutrientView.chartSideLength,
                           alignment: .center)
                Spacer(minLength: 0.0)
            }
            HStack {
                VStack(alignment: .center) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.fatColor)
                            .imageScale(.medium)
                        Text("Fat")
                    }
                    Text("\(fatPercentage(totalNutrient: totalNutrients))% - \(Int(totalNutrients.fat))g")
                }
                    .padding(.horizontal)
                VStack(alignment: .center) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.carbColor)
                            .imageScale(.medium)
                        Text("Carb")
                    }
                    Text("\(carbsPercentage(totalNutrient: totalNutrients))% - \(Int(totalNutrients.carbs))g")
                }
                    .padding(.horizontal)
                VStack(alignment: .center) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.proteinColor)
                            .imageScale(.medium)
                        Text("Protein")
                    }
                    Text("\(proteinPercentage(totalNutrient: totalNutrients))% - \(Int(totalNutrients.protein))g")
                }
                    .padding(.horizontal)
            }

            NavigationLink(destination:
                StatisticsNutrientWeeklyView(rootStore: self.rootStore,
                                            day: self.rootStore.getToday())
                ) {
                    HStack {
                        Text("Weekly")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.blue)
                        Spacer()
                        Text("More")
                            .foregroundColor(Color.blue)
                        Image(systemName: "chevron.right.circle")
                            .foregroundColor(Color.blue)
                            .imageScale(.medium)
                    }
            }
                .padding(.horizontal)
            
            BarChartView(data: convertNutrients(from: rootStore.plan),
                     tags: ["S", "M", "Tu", "W", "Th", "F", "Sa"],
                     colors: [Nutrient.fatColor, Nutrient.carbColor, Nutrient.proteinColor])
                .frame(height: StatisticsNutrientView.barChartHeight)
            
            HStack {
                VStack(alignment: .center) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.fatColor)
                            .imageScale(.medium)
                        Text("Fat")
                    }
                    Text("\(fatPercentage(totalNutrient: weeklyAvgNutrients))% - \(Int(weeklyAvgNutrients.fat))g")
                }
                    .padding(.horizontal)
                VStack(alignment: .center) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.carbColor)
                            .imageScale(.medium)
                        Text("Carb")
                    }
                    Text("\(carbsPercentage(totalNutrient: weeklyAvgNutrients))% - \(Int(weeklyAvgNutrients.carbs))g")
                }
                    .padding(.horizontal)
                VStack(alignment: .center) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Nutrient.proteinColor)
                            .imageScale(.medium)
                        Text("Protein")
                    }
                    Text("\(proteinPercentage(totalNutrient: weeklyAvgNutrients))% - \(Int(weeklyAvgNutrients.protein))g")
                }
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
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
        rootStore.getDay(on: Date())!.totalNutrients()
    }
    
    var weeklyAvgNutrients: Nutrient {
        rootStore.plan.weeklyAverageNutrients(withRespectTo: Date())
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
    
    private static var chartSideLength: CGFloat = 220
    private static var barChartHeight: CGFloat = 100
}

struct StatisticsNutrientView_Previews: PreviewProvider {
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
        return StatisticsNutrientView(rootStore: RootStore(plan: plan))
    }
}
