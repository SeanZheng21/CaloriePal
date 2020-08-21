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
    
    func savePlan(to rootStore: RootStore, gender: Bool, height: Float, age: Int, activityLevel: Int,
                  from startDate: Date, startWeight: Float, goalWeight: Float, rate: Float) -> Void {
        rootStore.plan.setGender(to: gender)
        rootStore.plan.setHeight(to: height)
        rootStore.plan.setAge(to: age)
        rootStore.plan.setActivityLevel(to: activityLevel)
        rootStore.plan.setStartDate(to: startDate)
        rootStore.plan.setStartWeight(to: startWeight)
        rootStore.plan.setGoalWeight(to: goalWeight)
        rootStore.plan.setRate(to: rate)
    }
        
    func resetPlan(rootStore: RootStore) -> Void {
        let newPlan = Plan(gender: true, height: 60, age: 18, activityLevel: 1, from: Date(), startWeight: 130, goalWeight: 120, rate: 1.0)
        rootStore.setPlan(plan: newPlan)
        self.plan = newPlan
    }
}
