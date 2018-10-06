//
//  DataStore.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import Foundation

class DataStore {
    var exercises = ["Regular Pushup", "Wide-Angle Pushup", "Tricep Pushup", "Decline Pushup", "Handstand from Squat", "Handstand Supported", "Sit-up", "Crunch", "Oblique", "Run-Trail", "Run-Road", "Run-Trail-and-Road"]
    
    var workouts = [
        ["date": "2018-10-03", "type": "calesthenics", "number": 1, "performed": true, "exercises": ["Regular Pushup", "Wide-Angle Pushup", "Tricep Pushup", "Decline Pushup", "Handstand from Squat"]],
        ["date": "2018-10-04", "type": "aerobic", "number": 1, "performed": true, "exercises": ["Run-Trail"]],
        ["date": "2018-10-07", "type": "calesthenics", "number": 1, "performed": false, "exercises": ["Sit-up", "Crunch", "Oblique"]]
    ]
}
