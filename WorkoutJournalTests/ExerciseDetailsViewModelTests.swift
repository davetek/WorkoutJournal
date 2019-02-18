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

///    Scenario: Exercise Names are Unique
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



}
