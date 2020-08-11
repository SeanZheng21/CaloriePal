//
//  PlanTests.swift
//  CaloriePalTests
//
//  Created by Carlistle ZHENG on 8/3/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import XCTest
@testable import CaloriePal

class PlanTests: XCTestCase {
    
    var plan: Plan = Plan(from: Date(), to: Date(timeIntervalSinceNow: 60*60*24*30), startWeight: 157, goalWeight: 155, rate: 1.0)
    
    override func setUpWithError() throws {
        plan = Plan(from: Date(), to: Date(timeIntervalSinceNow: 60*60*24*30), startWeight: 157, goalWeight: 155, rate: 1.0)
        plan.addDay(newDay: Day(date: Date(timeIntervalSinceNow: -60*60*24*3)))
        plan.addDay(newDay: Day(date: Date(timeIntervalSinceNow: -60*60*24*2)))
        plan.addDay(newDay: Day(date: Date(timeIntervalSinceNow: -60*60*24)))
        plan.addDay(newDay: Day(date: Date()))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetCurrentDay() throws {
        let day = plan.getOrCreateCurrentDay()
        XCTAssertTrue(day.date.onSameDay(otherDate: Date()))
    }
    
    func testCreateCurrentDay() throws {
        let _ = plan.getOrCreateCurrentDay()
        XCTAssertEqual(4, plan.days.count)
    }

    func testAddDay() {
        plan.addDay(newDay: Day(date: Date(timeIntervalSinceNow: 60*60*24*3)))
        XCTAssertTrue(plan.hasRecord(on: Date(timeIntervalSinceNow: 60*60*24*3)))
        XCTAssertEqual(5, plan.days.count)
    }
    
    func testRemoveDay() {
        plan.removeDay(on: Date(timeIntervalSinceNow: -60*60*24*3))
        XCTAssertFalse(plan.hasRecord(on: Date(timeIntervalSinceNow: -60*60*24*3)))
        XCTAssertEqual(3, plan.days.count)
    }
    
    func testHasRecord() {
        XCTAssertTrue(plan.hasRecord(on: Date(timeIntervalSinceNow: -60*60*24)))
    }
    
    func testDayRecord() {
        XCTAssertTrue(((plan.dayRecord(on: Date(timeIntervalSinceNow: -60*60*24))?.date.onSameDay(otherDate: Date(timeIntervalSinceNow: -60*60*24))) != nil))
        XCTAssertTrue(Date().onSameDay(otherDate: plan.dayRecord(on: Date())!.date))
    }
    
    func testPreviousDay() {
        let day = Day(date: Date(timeIntervalSinceNow: -60*60*24))
        XCTAssertTrue(plan.previousDay(withRespectTo: day).date.onSameDay(otherDate: Date(timeIntervalSinceNow: -60*60*24*2)))
    }
    
    func testFollowingDay() {
        let day = Day(date: Date(timeIntervalSinceNow: -60*60*24*2))
        XCTAssertTrue(plan.followingDay(withRespectTo: day).date.onSameDay(otherDate: Date(timeIntervalSinceNow: -60*60*24)))
    }
    
    func testWeekdaysInWeek() {
        let weekdays = plan.weekdaysInWeek(withRespectTo: Date())
        XCTAssertEqual(4, weekdays.count)
    }
    
    func testWeights() {
        var d = plan.days[0]
        d.setWeight(to: 157)
        plan.addDay(newDay: d)

        let weights = plan.weights()
        XCTAssertEqual(1, weights.count)
        XCTAssertEqual(157, weights[plan.days[3].date])
    }
}
