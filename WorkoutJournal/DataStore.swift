//
//  DataStore.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import Foundation

class DataStore {
    
    var exercises = [
        ["name": "Regular Pushup", "type": "calesthenics"], ["name": "Wide-Angle Pushup", "type": "calesthenics"], ["name": "Tricep Pushup", "type": "calesthenics"], ["name": "Decline Pushup", "type": "calesthenics"], ["name": "Handstand from Squat", "type": "calesthenics"], ["name": "Handstand Supported", "type": "calesthenics"], ["name": "Situp", "type": "core"], ["name": "Crunch", "type": "core"], ["name": "Oblique", "type": "core"], ["name": "Burpees", "type": "calesthenics"],["name": "Run-Trail", "type": "aerobic"], ["name": "Run-Road", "type": "aerobic"], ["name": "Run-Trail-and-Road", "type": "aerobic"]
    ]
    
    var exercisePlans = [
        ["id": 1234, "exercise": "Regular Pushup", "subplans": [["numSets": 0, "minRepsPerSet": 0, "maxRepsPerSet": 0, "minTimePerRep": 0, "maxTimePerRep": 0, "setRepsPyramidTo": 10, "setsRepsPyramidInterval": 2, "totalTime": 0, "totalDistance": 0]]],
        ["id": 1235, "exercise": "Wide-Angle Pushup", "subplans": [["numSets": 0, "minRepsPerSet": 0, "maxRepsPerSet": 0, "minTimePerRep": 0, "maxTimePerRep": 0, "setRepsPyramidTo": 10, "setsRepsPyramidInterval": 2, "totalTime": 0, "totalDistance": 0]]],
        ["id": 1236, "exercise": "Tricep Pushup", "subplans": [["numSets": 0, "minRepsPerSet": 0, "maxRepsPerSet": 0, "minTimePerRep": 0, "maxTimePerRep": 0, "setRepsPyramidTo": 10, "setsRepsPyramidInterval": 2, "totalTime": 0, "totalDistance": 0]]],
        ["id": 1237, "exercise": "Decline Pushup", "subplans": [["numSets": 0, "minRepsPerSet": 0, "maxRepsPerSet": 0, "minTimePerRep": 0, "maxTimePerRep": 0, "setRepsPyramidTo": 10, "setsRepsPyramidInterval": 2, "totalTime": 0, "totalDistance": 0]]],
        ["id": 1240, "exercise": "Handstand from Squat", "subplans": [["numSets": 3, "minRepsPerSet": 1, "maxRepsPerSet": 1, "minTimePerRep": 10, "maxTimePerRep": 15, "setRepsPyramidTo": 0, "setsRepsPyramidInterval": 0, "totalTime": 0, "totalDistance": 0]]],
        ["id": 1241, "exercise": "Handstand Supported", "subplans": [["numSets": 3, "minRepsPerSet": 1, "maxRepsPerSet": 1, "minTimePerRep": 20, "maxTimePerRep": 20, "setRepsPyramidTo": 0, "setsRepsPyramidInterval": 0, "totalTime": 0, "totalDistance": 0]]],
        ["id": 1245, "exercise": "Burpees", "subplans": [["numSets": 1, "minRepsPerSet": 5, "maxRepsPerSet": 5, "minTimePerRep": 0, "maxTimePerRep": 0, "setRepsPyramidTo": 0, "setsRepsPyramidInterval": 0],["numSets": 1, "minRepsPerSet": 7, "maxRepsPerSet": 7, "setRepsPyramidTo": 0, "setsRepsPyramidInterval": 0, "totalTime": 0, "totalDistance": 0],["numSets": 1, "minRepsPerSet": 10, "maxRepsPerSet": 10, "setRepsPyramidTo": 0, "setsRepsPyramidInterval": 0, "totalTime": 0, "totalDistance": 0]]],
        ["id": 1260, "exercise": "Situp", "subplans": [["numSets": 1, "minRepsPerSet": 20, "maxRepsPerSet": 20, "minTimePerRep": 0, "maxTimePerRep": 0, "setRepsPyramidTo": 0, "setsRepsPyramidInterval": 0, "totalTime": 0, "totalDistance": 0]]],
        ["id": 1261, "exercise": "Crunch", "subplans": [["numSets": 1, "minRepsPerSet": 20, "maxRepsPerSet": 20, "minTimePerRep": 0, "maxTimePerRep": 0, "setRepsPyramidTo": 0, "setsRepsPyramidInterval": 0, "totalTime": 0, "totalDistance": 0]]],
        ["id": 1262, "exercise": "Oblique", "subplans": [["numSets": 1, "minRepsPerSet": 20, "maxRepsPerSet": 20, "minTimePerRep": 0, "maxTimePerRep": 0, "setRepsPyramidTo": 0, "setsRepsPyramidInterval": 0, "totalTime": 0, "totalDistance": 0]]],
        ["id": 1300, "exercise": "Run-Trail", "subplans": [["numSets": 0, "minRepsPerSet": 0, "maxRepsPerSet": 0, "minTimePerRep": 0, "maxTimePerRep": 0, "setRepsPyramidTo": 0, "setsRepsPyramidInterval": 0, "totalTime": 0, "totalDistance": 2.50]]]
    ]
    
    var workouts = [
        ["date": "2018-10-03", "type": "calesthenics", "number": 1, "performed": true, "exercisePlans": [1234, 1235, 1236, 1237, 1240]],
        ["date": "2018-10-04", "type": "aerobic", "number": 1, "performed": true, "exercisePlans": [1300]],
        ["date": "2018-10-05", "type": "core", "number": 1, "performed": false, "exercisePlans": [1260, 1261, 1262]],
        ["date": "2018-10-06", "type": "calesthenics", "number": 1, "performed": true, "exercisePlans": [1240, 1241]]
    ]
}
