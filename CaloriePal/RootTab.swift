//
//  RootStore.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/3/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class RootStore: ObservableObject {
    @Published var plan: Plan
    
    init(plan: Plan) {
        self.plan = plan
    }
    
    func setPlan(plan: Plan) -> Void {
        self.plan = plan
    }
}
