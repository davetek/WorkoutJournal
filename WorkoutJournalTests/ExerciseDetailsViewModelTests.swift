//
//  ExerciseDetailsViewModelTests.swift
//  WorkoutJournalTests
//
//  Created by David Lawrence on 2/18/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import XCTest
@testable import WorkoutJournal

class ExerciseDetailsViewModelTests: XCTestCase {

///    Scenario: Unique Exercise Names are Allowed
    func testExerciseNamesUnique() {
        
        //    Given: a list of current exercise names
        let currentExerciseNames = ["EXERCISE_NAME_1", "EXERCISE_NAME_2", "EXERCISE_NAME_3"]
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: currentExerciseNames)
        
        //    Given: an exercise name string that is not in the current list of exercise names
        let exerciseName = "EXERCISE_NAME_99"
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validateExerciseName(exerciseName)
        
        //    Then: the validation succeeds
        XCTAssertTrue(result)
        
    }

    ///    Scenario: Non-Unique Exercise Names are not allowed
    func testExerciseNameNotUnique() {
        
        //    Given: a list of current exercise names
        let currentExerciseNames = ["EXERCISE_NAME_1", "EXERCISE_NAME_2", "EXERCISE_NAME_3"]
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: currentExerciseNames)
        
        //    Given: an exercise name string that is in the current list of exercise names
        let exerciseName = "EXERCISE_NAME_2"
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validateExerciseName(exerciseName)
        
        //    Then: the validation fails
        XCTAssertFalse(result)
        
    }
    
    
    ///    Scenario: Exercise Names is required
    func testExerciseNameRequired() {
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: [])
        
        //   Given: an empty exercise name string
        let exerciseName = ""
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validateExerciseName(exerciseName)
        
        //    Then: the validation fails
        XCTAssertFalse(result)
        
    }


}
