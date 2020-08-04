//
//  DayCalorieView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/2/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct DayCalorieView: View {
    @ObservedObject var dayBanner: DayBanner
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Text("CALORIES")
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
                MultiProgressBarView(multiProgressBar: MultiProgressBar(
                    total: Float(self.dayBanner.budgetCalories), values: [Float(self.dayBanner.netCalories)],
                    colors: [self.dayBanner.remainingCalories >= 0 ? Color.green : Color.yellow]))
                    .frame(height: DayCalorieView.progressBarHeight)
                HStack {
                    VStack {
                        Text("BUDGET")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Text("\(self.dayBanner.budgetCalories)")
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
                        Text("\(self.dayBanner.foodCalories)")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text("EXERCISE")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Text("\(self.dayBanner.exerciseCalories)")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text("NET")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                        Text("\(self.dayBanner.netCalories)")
                            .font(.callout)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    VStack {
                        Text(self.dayBanner.remainingCalories >= 0 ? "UNDER" : "OVER")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(self.dayBanner.remainingCalories >= 0 ?
                                Color.green : Color.red)
                        Text("\(abs(self.dayBanner.remainingCalories))")
                            .font(.callout)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .background(self.dayBanner.remainingCalories >= 0 ?
                            Color.green : Color.red)
                    }
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

struct DaySummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let breakfast = Meal(id: 1, type: .breakfast, foods: [foodData[0]])
        let lunch = Meal(id: 1, type: .lunch, foods: [foodData[1]])
        let dinner = Meal(id: 1, type: .dinner, foods: [foodData[2], foodData[3]])
        let snacks = Meal(id: 1, type: .snacks, foods: [foodData[2]])
        let exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
        let day = Day(breakfast: breakfast, lunch: lunch,
                    dinner: dinner, snacks: snacks, exercise: exercise)
        return DayCalorieView(dayBanner: DayBanner(day: day))
    }
}
