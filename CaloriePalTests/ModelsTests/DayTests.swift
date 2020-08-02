//
//  DayTests.swift
//  CaloriePalTests
//
//  Created by Carlistle ZHENG on 8/2/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import XCTest
@testable import CaloriePal

class DayTests: XCTestCase {
    var day = Day()
    
    override func setUpWithError() throws {
        let breakfast = Meal(id: 1, type: .breakfast, foods: [foodData[0]])
        let lunch = Meal(id: 1, type: .lunch, foods: [foodData[1]])
        let dinner = Meal(id: 1, type: .dinner, foods: [foodData[2], foodData[3]])
        let snacks = Meal(id: 1, type: .snacks, foods: [foodData[2]])
        let exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
        self.day = Day(breakfast: breakfast, lunch: lunch,
                    dinner: dinner, snacks: snacks, exercise: exercise)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFoodCalories() throws {
        let calorie = foodData[0].calorie + foodData[1].calorie + foodData[3].calorie + foodData[2].calorie * 2
        XCTAssertEqual(calorie, day.foodCalories())
    }

    func testExerciseCalories() throws {
        XCTAssertEqual(workoutData[0].calories, day.exerciseCalories())
    }
    
    func testTotalCalories() throws {
        let calorie = foodData[0].calorie + foodData[1].calorie + foodData[3].calorie + foodData[2].calorie * 2 - workoutData[0].calories
        XCTAssertEqual(calorie, day.totalCalories())
    }
    
    func testTotalNutrients() {
        let nutrient = day.breakfast.totalNutrient().addNutrient(otherNutrient: day.lunch.totalNutrient().addNutrient(otherNutrient: day.dinner.totalNutrient().addNutrient(otherNutrient: day.snacks.totalNutrient())))
        XCTAssertEqual(nutrient, day.totalNutrients())
    }
}
