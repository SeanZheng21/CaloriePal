//
//  ExerciseTests.swift
//  CaloriePalTests
//
//  Created by Carlistle ZHENG on 8/1/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import XCTest
@testable import CaloriePal

class ExerciseTests: XCTestCase {
    
    var exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
    override func setUpWithError() throws {
        exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWorkout() throws {
        let workout = Workout(id: 1, name: "Skateboarding", caloriePerMinute: 5, duration: 75, excluded: false)
        XCTAssertEqual(workout, workoutData[0])
    }
    
    func testworkoutIndex() throws {
        XCTAssertNil(exercise.workoutIndex(of: workoutData[2]))
        XCTAssertEqual(1, exercise.workoutIndex(of: workoutData[1]))
    }
    
    func testHasHood() throws {
        XCTAssertTrue(exercise.hasWorkout(of: workoutData[0]))
        XCTAssertFalse(exercise.hasWorkout(of: workoutData[2]))
    }

    func testAddworkout() {
        exercise.addWorkout(newWorkout: workoutData[2])
        XCTAssertTrue(exercise.hasWorkout(of: workoutData[2]))
    }
    
    func testRemoveworkout() {
        exercise.removeWorkout(workout: workoutData[0])
        XCTAssertEqual(exercise.workouts.count, 1)
        XCTAssertFalse(exercise.hasWorkout(of: workoutData[0]))
    }
    
    func testTotalCalories() {
        XCTAssertEqual(workoutData[0].calories + workoutData[1].calories,
                       exercise.totalCalories())
    }
    
    func testTotalDuration() {
        XCTAssertEqual(workoutData[0].duration + workoutData[1].duration,
                       exercise.totalDuration())
    }
}
