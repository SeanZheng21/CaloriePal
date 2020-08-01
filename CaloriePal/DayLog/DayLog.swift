//
//  DayLog.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import Foundation

class DayLog: ObservableObject {
    @Published var day: Day
    
    init(day: Day) {
        self.day = day
    }
    
    var dateString: String {
        day.dateString()
    }
    
    var breakfast: Meal {
        day.breakfast
    }
    
    var lunch: Meal {
        day.lunch
    }
    
    var dinner: Meal {
        day.dinner
    }
    
    var snacks: Meal {
        day.snacks
    }
    
    var exercise: Exercise {
        day.exercise
    }
}
