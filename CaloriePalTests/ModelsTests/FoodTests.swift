//
//  FoodTests.swift
//  CaloriePalTests
//
//  Created by Carlistle ZHENG on 7/29/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import XCTest
@testable import CaloriePal

class FoodTests: XCTestCase {
    var food: Food?
    override func setUpWithError() throws {
        food = Food(id: 1, name: "Chicken Noodle", nutrient: Nutrient(fat: 1.5, satFat: 1, cholesterol: 12.2, sodium: 473.9, carbs: 12.6, fiber: 1.9, sugars: 1.4, protein: 9), caloriePerUnit: 100, amount: FoodAmount(unit: .cup, amount: 1), type: .drink)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJsonString() {
        XCTAssertEqual(foodData[0].name, "Chicken Noodle")
        XCTAssertEqual(1, foodData[0].id)
    }
    
    func testFormatNutrient() {
        XCTAssertEqual("1", Nutrient.formatNutrient(1.0))
        XCTAssertEqual("1", Nutrient.formatNutrient(1.00))
    }
}
