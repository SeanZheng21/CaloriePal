//
//  MealTests.swift
//  CaloriePalTests
//
//  Created by Carlistle ZHENG on 7/30/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import XCTest
@testable import CaloriePal

class MealTests: XCTestCase {
    var meal: Meal = Meal(id: 1, type: .breakfast,
                          foods: [foodData[0], foodData[1]])
    
    override func setUpWithError() throws {
        meal = Meal(id: 1, type: .breakfast,
                    foods: [foodData[0], foodData[1]])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFoodIndex() throws {
        XCTAssertNil(meal.foodIndex(of: foodData[2]))
        XCTAssertEqual(1, meal.foodIndex(of: foodData[1]))
    }
    
    func testHasHood() throws {
        XCTAssertTrue(meal.hasFood(food: foodData[0]))
        XCTAssertFalse(meal.hasFood(food: foodData[3]))
    }

    func testAddFood() {
        meal.addFood(newFood: foodData[3])
        XCTAssertTrue(meal.hasFood(food: foodData[3]))
    }
    
    func testRemoveFood() {
        meal.removeFood(food: foodData[0])
        XCTAssertEqual(meal.foods.count, 1)
        XCTAssertFalse(meal.hasFood(food: foodData[0]))
    }
    
    func testSetFood() {
        let food = Food(id: 1, name: "Noodle", nutrient: Nutrient(fat: 1, satFat: 1, cholesterol: 1, sodium: 1, carbs: 1, fiber: 1, sugars: 1, protein: 1), caloriePerUnit: 1, amount: FoodAmount(unit: .liter, amount: 3.5), type: .drink)
        let foodStr = food.toJsonString()
        meal.setFood(food: food)
        XCTAssertEqual(foodStr, meal.foods[0].toJsonString())
    }
    
    func testTotalCalories() {
        XCTAssertEqual(foodData[0].calorie + foodData[1].calorie,
                       meal.totalCalories())
    }
}
