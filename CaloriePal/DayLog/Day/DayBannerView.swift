//
//  DayBannerView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/2/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct DayBannerView: View {
    @ObservedObject var dayBanner: DayBanner

    var body: some View {
        PageView( [AnyView(DayCalorieView(dayBanner: DayBanner(day: dayBanner.getDay()))),
                   AnyView(DayNutrientView(dayBanner: DayBanner(day: dayBanner.getDay())))] )
    }
    
    // MARK: - Drawing Constants
    static let viewHeight: CGFloat = 120.0
}

struct DayBannerView_Previews: PreviewProvider {
    static var previews: some View {
        let breakfast = Meal(id: 1, type: .breakfast, foods: [foodData[0]])
        let lunch = Meal(id: 1, type: .lunch, foods: [foodData[1]])
        let dinner = Meal(id: 1, type: .dinner, foods: [foodData[2], foodData[3]])
        let snacks = Meal(id: 1, type: .snacks, foods: [foodData[2]])
        let exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
        let day = Day(breakfast: breakfast, lunch: lunch,
                    dinner: dinner, snacks: snacks, exercise: exercise)
        return DayBannerView(dayBanner: DayBanner(day: day))
    }
}
