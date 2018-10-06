//
//  DataStore.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import Foundation

class DataStore {
    
    var exercises = [["name": "Regular Pushup", "type": "calesthenics"], ["name": "Wide-Angle Pushup", "type": "calesthenics"], ["name": "Tricep Pushup", "type": "calesthenics"], ["name": "Decline Pushup", "type": "calesthenics"], ["name": "Handstand from Squat", "type": "calesthenics"], ["name": "Handstand Supported", "type": "calesthenics"], ["name": "Situp", "type": "core"], ["name": "Crunch", "type": "core"], ["name": "Oblique", "type": "core"], ["name": "Run-Trail", "type": "aerobic"], ["name": "Run-Road", "type": "aerobic"], ["name": "Run-Trail-and-Road", "type": "aerobic"]]
    
    var workouts = [
        ["date": "2018-10-03", "type": "calesthenics", "number": 1, "performed": true, "exercises": ["Regular Pushup", "Wide-Angle Pushup", "Tricep Pushup", "Decline Pushup", "Handstand from Squat"]],
        ["date": "2018-10-04", "type": "aerobic", "number": 1, "performed": true, "exercises": ["Run-Trail"]],
        ["date": "2018-10-05", "type": "core", "number": 1, "performed": false, "exercises": ["Sit-up", "Crunch", "Oblique"]],
        ["date": "2018-10-06", "type": "calesthenics", "number": 1, "performed": true, "exercises": ["Handstand from Squat", "Handstand Supported"]]
    ]
}
