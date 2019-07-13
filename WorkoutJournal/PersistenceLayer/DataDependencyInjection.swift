//
//  DataDependencyInjection.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/15/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import Foundation

//to be used by any high-level view controller into which the data store
// should be injected from the root tab bar controller

protocol DataDependencyInjection {
        
    func instantiateViewModelWithDataStore(_ dataStore: WorkoutJournalDataStore)
}
