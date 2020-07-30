//
//  FoodConvertionTests.swift
//  CaloriePalTests
//
//  Created by Carlistle ZHENG on 7/29/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import XCTest
@testable import CaloriePal

class FoodConvertionTests: XCTestCase {
    var food: Food = foodData[0]
    override func setUpWithError() throws {
        food = foodData[0]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetAmount()  {
        // Used to be 1 cup
        food.setAmount(to: 2.25)
        XCTAssertEqual(FoodAmount(unit: .cup, amount: 2.25), food.amount)
    }
    
    func testSetUnit()  {
        // Used to be 1 cup
        food.setUnit(to: .pint)
        XCTAssertEqual(FoodAmount(unit: .pint, amount: 0.5), food.amount)
    }

}
