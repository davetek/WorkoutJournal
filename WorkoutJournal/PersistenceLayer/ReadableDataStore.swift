//
//  ReadableDataStore.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/4/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import Foundation

protocol ReadableDataStore {
    //if using Core Data, this corresponds to NSManagedContext,
    // but only specifies methods that retrieve data
    
    func retrieveData<T: Entity>(matching query: Query) -> [T]
}
