//
//  DataDependencyInjection.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/15/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import Foundation

protocol DataDependencyInjection {
        
    func instantiateViewModelWithDataStore(_ dataStore: WorkoutJournalDataStore)
}
