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

///    Scenario: Exercise name that is unique is allowed
    func testExerciseNameUnique() {
        
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

    ///    Scenario: Exercise name that is not unique is not allowed
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
    
    
    ///    Scenario: Exercise name that is empty string is not allowed
    func testExerciseNameNotEmptyString() {
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: [])
        
        //   Given: an empty exercise name string
        let exerciseName = ""
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validateExerciseName(exerciseName)
        
        //    Then: the validation fails
        XCTAssertFalse(result)
    }
    
    
    ///    Scenario: Exercise name that is nil is not allowed
    func testExerciseNameNotNil() {
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: [])
        
        //   Given: a nil optional variable for exerciseName variable
        var exerciseName: String?
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validateExerciseName(exerciseName)
        
        //    Then: the validation fails
        XCTAssertFalse(result)
    }
    
    
    


}
