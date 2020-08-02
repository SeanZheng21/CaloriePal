//
//  DayCalorieView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/2/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct DayCalorieView: View {
    @ObservedObject var daySummary: DaySummary
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Text("CALORIES")
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                MultiProgressBarView(multiProgressBar: MultiProgressBar(total: Float(self.daySummary.budgetCalories), values: [Float(self.daySummary.netCalories)],
                    colors: [self.daySummary.remainingCalories >= 0 ? Color.green : Color.yellow]))
                    .frame(height: DayCalorieView.progressBarHeight)
                HStack {
                    VStack {
                        Text("BUDGET")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Text("\(self.daySummary.budgetCalories)")
                            .font(.callout)
                            .foregroundColor(Color.blue)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text("FOOD")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Text("\(self.daySummary.foodCalories)")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text("EXERCISE")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Text("\(self.daySummary.exerciseCalories)")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text("NET")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Text("\(self.daySummary.netCalories)")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text(self.daySummary.remainingCalories >= 0 ? "UNDER" : "OVER")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(self.daySummary.remainingCalories >= 0 ?
                                Color.green : Color.red)
                        Text("\(abs(self.daySummary.remainingCalories))")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .background(self.daySummary.remainingCalories >= 0 ?
                            Color.green : Color.red)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            .frame(width: geometry.size.width, height: DayCalorieView.summaryViewHeight)
            .background(Color.gray.opacity(DayCalorieView.backgroundOpacity))
        }
    }
    
    // MARK: - Drawing Constants
    static let progressBarHeight: CGFloat = 15.0
    static let summaryViewHeight: CGFloat = 100.0
    static let backgroundOpacity: Double = 0.15
}

struct DaySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let breakfast = Meal(id: 1, type: .breakfast, foods: [foodData[0]])
        let lunch = Meal(id: 1, type: .lunch, foods: [foodData[1]])
        let dinner = Meal(id: 1, type: .dinner, foods: [foodData[2], foodData[3]])
        let snacks = Meal(id: 1, type: .snacks, foods: [foodData[2]])
        let exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
        let day = Day(breakfast: breakfast, lunch: lunch,
                    dinner: dinner, snacks: snacks, exercise: exercise)
        return DayCalorieView(daySummary: DaySummary(day: day))
    }
}
