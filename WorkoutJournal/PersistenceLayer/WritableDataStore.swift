//
//  WritableDataStore.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/4/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import Foundation

protocol WritableDataStore {
    //if using Core Data, this corresponds to NSManagedContext,
    // but only specifies methods that change data:
    // add, update, or delete a record, and save all data
    
    func add<T: Entity>(_ entity: T)
    func update<T: Entity>(_ entity: T)
    func delete<T: Entity>(_ entity: T)
    
    func saveAllData()
}



