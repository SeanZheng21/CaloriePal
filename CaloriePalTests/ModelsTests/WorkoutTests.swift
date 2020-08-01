//
//  WorkoutTests.swift
//  CaloriePalTests
//
//  Created by Carlistle ZHENG on 8/1/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import XCTest
@testable import CaloriePal

class WorkoutTests: XCTestCase {
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let workout = Workout(id: 1, name: "Skateboarding", caloriePerMinute: 5, duration: 30)
        XCTAssertEqual(workout, workoutData[0])
    }
}
