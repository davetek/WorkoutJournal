//
//  Persistence.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/6/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import Foundation


//** These Protocols Define the Abstract Persistence Layer


//corresponds to NSFetchRequest when using Core Data
//"collects the criteria needed to select and optionally to
// sort a group of managed objects held in a persistent store"
protocol Query {
    
    //corresponds to SQL SELECT statement FROM clause
    // and var entityName in NSFetchRequest
    var fromModelName: String? {get}
    
    //corresponds to SQL SELECT statement ORDER BY clause
    var orderBy: [NSSortDescriptor]? {get set}
    
    //corresponds to SQL SELECT statemement WHERE clause
    var filterBy: NSPredicate? {get set}
}


//corresponds to NSEntityDescription
protocol Model {
    
    //if Core Data, conforming type will create an NSFetchRequest for this Entity
    static func generateQuery() -> Query
    
    static func generateSortDescriptor(forKey key: String, ascending: Bool) -> NSSortDescriptor
}


//can be implemented by NSManagedContext     Datastore
protocol ReadableDataStore {
    
    //the Model type T can be obtained from the query Q
    func fetchData<T: Model, Q: Query>(withQuery: Q) -> [T]
}


//can be implemented by NSManagedContext
protocol WritableDataStore {
    
    //generic function that will take as parameters  dictionary passed to it
    //func addModelItem<T: Model>(ofType modelType: T.Type, withProperties properties: [String: Any])
    
    //func update<T: Model>(modelObject: T, withProperties properties: [String: Any])
    
    func delete<T: Model>(dataObject: T)
    
    func saveChanges()
}

//
typealias DataStore = ReadableDataStore & WritableDataStore


//** These Protocols Define the Specific Persistence Models Used in an App

protocol ExerciseTypeModel {
    var name: String? {get set}
    var exercises: NSSet? {get set} //set of ExerciseModel objects
    
    func addWith(name: String?, dataStore: DataStore?)
    func updateWith(name: String?)
}

protocol ExerciseModel {
    var name: String? {get set}
    var url: String? {get set}
    var exerciseType: ExerciseTypeModel? {get set}
    
    static func addWith(name: String?, exerciseType: ExerciseTypeModel?, url: String?, dataStore: DataStore?)
    func updateWith(name: String?, exerciseType: ExerciseTypeModel?, url: String?)
}






