//
//  PersonMO+CoreDataProperties.swift
//  CoreDataTutorial
//
//  Created by Miguel Fagundez on 11/8/15.
//  Copyright © 2015 Miguel Fagundez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension PersonMO {

    @NSManaged var person_name: String?
    @NSManaged var chore_log: NSSet?

}
