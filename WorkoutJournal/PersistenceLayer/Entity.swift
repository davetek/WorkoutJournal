//
//  Entity.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/4/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import Foundation

protocol Entity {
    //this corresponds to the NSManagedObject class when using Core Data
    
    //for Core Data, this would be the fetchRequest() method of NSManagedObject
    func generateQueryForThisEntity() -> Query
}
