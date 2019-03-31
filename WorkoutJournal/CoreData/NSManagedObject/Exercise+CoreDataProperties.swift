//
//  Exercise+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 3/31/19.
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
    @NSManaged public var url: String?
    @NSManaged public var exerciseTypes: ExerciseType?

}
