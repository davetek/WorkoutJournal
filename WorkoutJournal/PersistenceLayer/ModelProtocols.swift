//
//  ModelProtocols.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/13/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import Foundation

//** These Protocols Define the Specific Persistence Models Used in an App

protocol ExerciseTypeModel {
    var name: String? {get set}
    var exercises: NSSet? {get set} //set of ExerciseModel objects
}

protocol ExerciseModel {
    var name: String? {get set}
    var url: String? {get set}
    var exerciseType: ExerciseTypeModel? {get set}
}

protocol ExercisePlanModel {
    var repsPerSet: Int16 {get set}
    var restBtwnSets: Int16 {get set}
    var sets: Int16 {get set}
    var setsPyramidDblPeakTo: Int16 {get set}
    var setsPyramidStepSize: Int16 {get set}
    var setsPyramidTo: Int16 {get set}
    var setTimeDuration: Int16 {get set}
    var setsTotalTime: Int16 {get set}
    var setDistance: Int16 {get set}
    var setsTotalDistance: Int16 {get set}
    
    var exercise: Exercise? {get set}
}
    
protocol RoutineModel {
    /*
     pattern  // circuit-by-reps, circuit-by-times, HIT, intervals
     <sequence of
    */
    //var exercisePlanInRoutine: ExercisePlanInRoutine? {get set}
}

protocol ExercisePlanInRoutineModel {
    
    //var routine: Routine? {get set}
    var exercise: Exercise? {get set}
    var sequence: Int16 {get set}
}
