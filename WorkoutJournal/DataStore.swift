//
//  DataStore.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import Foundation

class DataStore {
    
    struct Exercise {
        var id: Int
        var name: String
        var type: String
    }
    
    //describes how an exercise is performed
    // also contains information that identifies the muscle groups worked
    // and the type of fitness the exercise provides, i.e. "strength", "core", "aerobic"
    // could also differentiate between bodyweight and weightlifting exercises
    struct ExercisePlan {
        var id: Int
        var performed: Bool     //true if exercise was done, false otherwise
        var exercise: Int       //id for Exercise instance
        var numSets: Int
        var minRepsPerSet: Int
        var maxRepsPerSet: Int
        var minTimePerRep: Int
        var maxTimePerRep: Int
        var setsRepsPyramidTo: Int
        var setsRepsPyramidInterval: Int
        var totalTime: Int
        var totalDistance: Double
    }

    
    
    var exercises = [
        Exercise(id: 5001, name: "Regular Pushup", type: "calesthenics"),
        Exercise(id: 5002, name: "Wide-Angle Pushup", type: "calesthenics"),
        Exercise(id: 5003, name: "Tricep Pushup", type: "calesthenics"),
        Exercise(id: 5004, name: "Decline Pushup", type: "calesthenics"),
        Exercise(id: 5005, name: "Handstand from Squat", type: "calesthenics"),
        Exercise(id: 5006, name: "Handstand Supported", type: "calesthenics"),
        Exercise(id: 5007, name: "Situp", type: "core"),
        Exercise(id: 5008, name: "Crunch", type: "core"),
        Exercise(id: 5009, name: "Oblique", type: "core"),
        Exercise(id: 5010, name: "Burpees", type: "calesthenics"),
        Exercise(id: 5011, name: "Run-Trail", type: "aerobic"),
        Exercise(id: 5012, name: "Run-Road", type: "aerobic"),
        Exercise(id: 5013, name: "Run-Trail-and-Road", type: "aerobic"),
        Exercise(id: 5020, name: "Walk-Trail-Easy", type: "aerobic"),
        Exercise(id: 5021, name: "Walk-Road", type: "aerobic"),
        Exercise(id: 5999, name: "Rest", type: "rest")
    ]
    
    var exercisePlans = [
        ExercisePlan(id: 1234, performed: true, exercise: 5001, numSets: 0, minRepsPerSet: 0, maxRepsPerSet: 0, minTimePerRep: 0, maxTimePerRep: 0, setsRepsPyramidTo: 10, setsRepsPyramidInterval: 2, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1235, performed: true, exercise: 5002, numSets: 0, minRepsPerSet: 0, maxRepsPerSet: 0, minTimePerRep: 0, maxTimePerRep: 0, setsRepsPyramidTo: 10, setsRepsPyramidInterval: 2, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1236, performed: true, exercise: 5003, numSets: 0, minRepsPerSet: 0, maxRepsPerSet: 0, minTimePerRep: 0, maxTimePerRep: 0, setsRepsPyramidTo: 10, setsRepsPyramidInterval: 2, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1237, performed: true, exercise: 5004, numSets: 0, minRepsPerSet: 0, maxRepsPerSet: 0, minTimePerRep: 0, maxTimePerRep: 0, setsRepsPyramidTo: 10, setsRepsPyramidInterval: 2, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1240, performed: true, exercise: 5005, numSets: 3, minRepsPerSet: 1, maxRepsPerSet: 1, minTimePerRep: 10, maxTimePerRep: 15, setsRepsPyramidTo: 0, setsRepsPyramidInterval: 0, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1241, performed: true, exercise: 5006, numSets: 3, minRepsPerSet: 1, maxRepsPerSet: 1, minTimePerRep: 20, maxTimePerRep: 20, setsRepsPyramidTo: 0, setsRepsPyramidInterval: 0, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1245, performed: true, exercise: 5010, numSets: 1, minRepsPerSet: 5, maxRepsPerSet: 5, minTimePerRep: 0, maxTimePerRep: 0, setsRepsPyramidTo: 0, setsRepsPyramidInterval: 0, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1246, performed: true, exercise: 5010, numSets: 1, minRepsPerSet: 10, maxRepsPerSet: 10, minTimePerRep: 0, maxTimePerRep: 0, setsRepsPyramidTo: 0, setsRepsPyramidInterval: 0, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1260, performed: true, exercise: 5007, numSets: 1, minRepsPerSet: 20, maxRepsPerSet: 20, minTimePerRep: 0, maxTimePerRep: 0, setsRepsPyramidTo: 0, setsRepsPyramidInterval: 0, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1261, performed: true, exercise: 5008, numSets: 1, minRepsPerSet: 20, maxRepsPerSet: 20, minTimePerRep: 0, maxTimePerRep: 0, setsRepsPyramidTo: 0, setsRepsPyramidInterval: 0, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1262, performed: true, exercise: 5009, numSets: 1, minRepsPerSet: 20, maxRepsPerSet: 20, minTimePerRep: 0, maxTimePerRep: 0, setsRepsPyramidTo: 0, setsRepsPyramidInterval: 0, totalTime: 0, totalDistance: 0),
        ExercisePlan(id: 1300, performed: true, exercise: 5011, numSets: 0, minRepsPerSet: 0, maxRepsPerSet: 0, minTimePerRep: 0, maxTimePerRep: 0, setsRepsPyramidTo: 0, setsRepsPyramidInterval: 0, totalTime: 0, totalDistance: 2.50),
        ExercisePlan(id: 1400, performed: true, exercise: 5999, numSets: 0, minRepsPerSet: 1, maxRepsPerSet: 1, minTimePerRep: 30, maxTimePerRep: 30, setsRepsPyramidTo: 0, setsRepsPyramidInterval: 0, totalTime: 0, totalDistance: 0)

    ]
    
    //describes a pattern consisting of one more exercise plans (performances)
    // which may be repeated, and may include a rest between exercises
    struct Routine {
        var id: Int
        var name: String
        var type: String            //"circuit", "intervals"
        var trackRepetitions: Bool  //true if track reps over 1; false if not
        var repetitions: Int
        var timePerRepetition: Int  //units should be specified; untracked if 0
        var totalTime: Int          //units should be specified; untracked if 0
        var totalDistance: Int      //units should be specified; untracked if 0
        var exercisePlans: [Int]  //array of id's for ExercisePlans
    }
    
    var routines = [
        Routine(id: 7001, name: "strength", type: "circuit", trackRepetitions: false, repetitions: 1, timePerRepetition: 0, totalTime: 0, totalDistance: 0, exercisePlans: [1234, 1235, 1236, 1237]),
        Routine(id: 7002, name: "core", type: "circuit", trackRepetitions: true, repetitions: 2, timePerRepetition: 0, totalTime: 0, totalDistance: 0, exercisePlans: [1240, 1246, 1400]),
        Routine(id: 7003, name: "burpees intervals", type: "intervals", trackRepetitions: false, repetitions: 1, timePerRepetition: 0, totalTime: 0, totalDistance: 0, exercisePlans: [1246, 1400])
    ]
    
    //describes one or more exercise routines performed consecutively
    struct Workout {
        var id: Int
        var startDate: String   // TO DO: convert to Date type
        var endDate: String     // TO DO: convert to Date type
        var type: String        // TO DO: convert to a calculate from exercise types; different fields? - muscle group, push / pull, strength or core, etc.
        var routines: [Int]     //array of id's for Routines in workout
    }
    
    var workouts = [
        Workout(id: 8001, startDate: "2018-10-03", endDate: "2018-10-03", type: "tbd", routines: [7002, 7001]),
        Workout(id: 8002, startDate: "2018-10-04", endDate: "2018-10-04", type: "tbd", routines: [7002]),
        Workout(id: 8003, startDate: "2018-10-05", endDate: "2018-10-05", type: "tbd", routines: [7003, 7002])
    ]
}
