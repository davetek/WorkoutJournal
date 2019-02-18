//
//  ExerciseDetailsViewModel.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 2/18/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//


class ExerciseDetailsViewModel {
    
    let currentExerciseNames: [String]
    
    init(currentExerciseNames: [String]) {
        self.currentExerciseNames = currentExerciseNames
    }
    
    
    func validateExerciseName(_ exerciseName: String) -> Bool {
        if exerciseName.isEmpty {
            return false
        }
        else if !currentExerciseNames.contains(exerciseName) {
            return true
        } else {
            return false
        }
        
        
    }
    
}

