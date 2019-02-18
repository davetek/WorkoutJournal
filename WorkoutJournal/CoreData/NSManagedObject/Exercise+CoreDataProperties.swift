//
//  Exercise+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 1/28/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?

}
