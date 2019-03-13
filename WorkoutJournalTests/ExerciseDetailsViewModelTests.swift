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
        let currentExerciseNames = ["exercise_name_1", "exercise_name_2", "exercise_name_3"]
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: currentExerciseNames)
        
        //    Given: an exercise name string that is not in the current list of exercise names
        let exerciseName = "EXERCISE_NAME_99"
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validate(exerciseName: exerciseName)
        
        //    Then: the validation succeeds
        XCTAssertTrue(result)
        
    }
    

    ///    Scenario: Exercise name that is not unique is not allowed
    func testExerciseNameNotUnique() {
        
        //    Given: a list of current exercise names
        let currentExerciseNames = ["exercise_name_1", "exercise_name_2", "exercise_name_3"]
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: currentExerciseNames)
        
        //    Given: an exercise name string that is in the current list of exercise names (case insensitive)
        let exerciseName = "Exercise_name_2"
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validate(exerciseName: exerciseName)
        
        //    Then: the validation fails
        XCTAssertFalse(result)
    }
    
    
    ///    Scenario: Exercise name that is empty string is not allowed
    func testExerciseNameNotEmptyString() {
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel()
        
        //   Given: an empty exercise name string
        let exerciseName = ""
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validate(exerciseName: exerciseName)
        
        //    Then: the validation fails
        XCTAssertFalse(result)
    }
    
    
    ///    Scenario: Exercise name that is nil is not allowed
    func testExerciseNameNotNil() {
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel()

        //   Given: a nil optional variable for exerciseName variable
        var exerciseName: String?
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validate(exerciseName: exerciseName)
        
        //    Then: the validation fails
        XCTAssertFalse(result)
    }
    
    
    
    ///    Scenario: Exercise type that is in exercise types list is allowed
    func testExerciseTypeInExerciseTypesList() {
        
        // Given: a list of exercise types
        let exerciseTypes = ["Aerobic", "Calisthenics", "Core", "Weight-Training"]

        
        // Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel(exercisetypes: exerciseTypes)
        
        // Given: an exercise type that is a member of the list of exercise types
        let exerciseType = "Core"
        
        // When: the exercise type is validated
        let result = exerciseDetailsViewModel.validateExerciseType(exerciseType)
    
        // Then: the validation passes
        XCTAssertTrue(result)
    }


    ///    Scenario: Exercise type that is not exercise types list is not allowed
    func testExerciseTypeNotInExerciseTypesList() {
        
        // Given: a list of exercise types
        let exerciseTypes = ["Aerobic", "Calisthenics", "Core", "Weight-Training"]
        
        
        // Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel(exercisetypes: exerciseTypes)
        
        // Given: an exercise type that is a member of the list of exercise types
        let exerciseType = "Breakdancing"
        
        // When: the exercise type is validated
        let result = exerciseDetailsViewModel.validateExerciseType(exerciseType)
        
        // Then: the validation passes
        XCTAssertFalse(result)
    }
    
    ///    Scenario: Exercise type that is empty string is not allowed
    func testExerciseTypeNotEmptyString() {
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel()
        
        //   Given: an empty exercise name string
        let exerciseType = ""
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validateExerciseType(exerciseType)
        
        //    Then: the validation fails
        XCTAssertFalse(result)
    }
    
    
    ///    Scenario: Exercise type that is nil is not allowed
    func testExerciseTypeNotNil() {
        
        //    Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel()
        
        //   Given: a nil optional variable for exerciseName variable
        var exerciseType: String?
        
        //    When: the exercise name is validated
        let result = exerciseDetailsViewModel.validateExerciseType(exerciseType)
        
        //    Then: the validation fails
        XCTAssertFalse(result)
    }
    
    
    ///   Scenario: Exercise URL that is a valid http URI according to IETF standards is allowed
    func testExerciseUrlIsValidHttpUri() {
        
        // Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel()
        
        // Given: a URL that is a valid http URI according to RFC 7230
        let exerciseUrl = "http://clarityforaction.com"
        
        // When: the exercise type is validated
        let result = exerciseDetailsViewModel.validateExerciseUrl(exerciseUrl)
        
        // Then: the validation passes
        XCTAssertTrue(result)
    }
    
    
    ///   Scenario: Exercise URL that is a valid https URI according to IETF standards is allowed
    func testExerciseUrlIsValidHttpsUri() {
        
        // Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel()
        
        // Given: a URL that is a valid http URI according to RFC
        let exerciseUrl = "https://www.google.com"
        
        // When: the exercise type is validated
        let result = exerciseDetailsViewModel.validateExerciseUrl(exerciseUrl)
        
        // Then: the validation passes
        XCTAssertTrue(result)
    }
    
    
    ///   Scenario: Exercise URL that is not a valid http or https URI according to IETF standards is not allowed
    func testExerciseUrlIsNotValidHttpOrHttpsUri() {
        
        // Given: an Exercise Details view model
        let exerciseDetailsViewModel = ExerciseDetailsViewModel()
        
        // Given: a URL that is a valid http URI according to RFC
        let exerciseUrl = "a;fjd;adlskfj"
        
        // When: the exercise type is validated
        let result = exerciseDetailsViewModel.validateExerciseUrl(exerciseUrl)
        
        // Then: the validation passes
        XCTAssertFalse(result)
    }


    
}



extension ExerciseDetailsViewModel {
    //provide convenience initializers to allow each unit test to only pass
    // the parameter(s) relevant to that test
    // or to pass no parameters if none are relevant
    
    //define a default value for each of the parameters required in the designated initializer
    convenience init() {
        self.init(currentExerciseNames: [], exerciseTypes: [])
    }
    
    //define a default value for exerciseTypes, and use the parameter value passed for currentExerciseNames
    convenience init(currentExerciseNames: [String]) {
        self.init(currentExerciseNames: currentExerciseNames, exerciseTypes: [])
    }
    
    //define a default value for currentExerciseTypes, and use the parameter value passed for exerciseTypes
    convenience init(exercisetypes: [String]) {
        self.init(currentExerciseNames: [], exerciseTypes: exercisetypes)
    }
}
