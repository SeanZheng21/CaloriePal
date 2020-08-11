//
//  GoalViewModel.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/11/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class GoalViewModel: ObservableObject {
    init() {
        
    }
    
    func updateWeight(weight: Float, date: Date, rootStore: RootStore) -> Void {
        rootStore.plan.updateWeight(date: date, weight: weight)
    }
}
