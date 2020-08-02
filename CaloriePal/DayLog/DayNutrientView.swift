//
//  DayNutrientView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/2/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct DayNutrientView: View {
    @ObservedObject var daySummary: DayBanner
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Text("MACRONUTRIENTS")
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                    .padding(.top)
                MultiProgressBarView(multiProgressBar: MultiProgressBar(total: Float(self.daySummary.budgetCalories),
                    values: [Float(self.daySummary.netCalories * self.daySummary.fatPercentage) / 100.0,
                            Float(self.daySummary.netCalories * self.daySummary.carbsPercentage) / 100.0,
                            Float(self.daySummary.netCalories * self.daySummary.proteinPercentage) / 100.0],
                    colors: [Nutrient.fatColor, Nutrient.carbColor, Nutrient.proteinColor]))
                    .frame(height: DayCalorieView.progressBarHeight)
                HStack {
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Nutrient.fatColor)
                                .imageScale(.small)
                            Text("FAT")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color.gray)
                        }
                        Text("\(Int(self.daySummary.fatPercentage))%")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Nutrient.carbColor)
                                .imageScale(.small)
                            Text("CARB")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color.gray)
                        }
                        Text("\(Int(self.daySummary.carbsPercentage))%")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Nutrient.proteinColor)
                                .imageScale(.small)
                            Text("PROTEIN")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(Color.gray)
                        }
                        Text("\(Int(self.daySummary.proteinPercentage))%")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                Text("")
                Text("")
            }
            .padding(.vertical)
            .frame(width: geometry.size.width, height: DayCalorieView.viewHeight)
            .background(Color.gray.opacity(DayCalorieView.backgroundOpacity))
        }
    }
    
    // MARK: - Drawing Constants
    static let progressBarHeight: CGFloat = 15.0
    static let viewHeight: CGFloat = 120.0
    static let backgroundOpacity: Double = 0.15
}

struct DayNutrientView_Previews: PreviewProvider {
    static var previews: some View {
        let breakfast = Meal(id: 1, type: .breakfast, foods: [foodData[0]])
        let lunch = Meal(id: 1, type: .lunch, foods: [foodData[1]])
        let dinner = Meal(id: 1, type: .dinner, foods: [foodData[2], foodData[3]])
        let snacks = Meal(id: 1, type: .snacks, foods: [foodData[2]])
        let exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
        let day = Day(breakfast: breakfast, lunch: lunch,
                    dinner: dinner, snacks: snacks, exercise: exercise)
        return DayNutrientView(daySummary: DayBanner(day: day))
    }
}
