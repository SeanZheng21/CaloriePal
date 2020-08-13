//
//  GoalEditor.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/12/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class GoalEditor: ObservableObject {
    @Published var plan: Plan
    
    init(plan: Plan) {
        self.plan = plan
    }
    
    func savePlan(to rootStore: RootStore, gender: Bool, height: Float, age: Int, activityLevel: Int, from startDate: Date, startWeight: Float, goalWeight: Float, rate: Float) -> Void {
        rootStore.plan.setGender(to: gender)
        rootStore.plan.setHeight(to: height)
        rootStore.plan.setAge(to: age)
        rootStore.plan.setActivityLevel(to: activityLevel)
        rootStore.plan.setStartDate(to: startDate)
        rootStore.plan.setStartWeight(to: startWeight)
        rootStore.plan.setGoalWeight(to: goalWeight)
        rootStore.plan.setRate(to: rate)
    }
}
