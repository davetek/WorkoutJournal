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
