//
//  ChoreLogMO.swift
//  CoreDataTutorial
//
//  Created by Miguel Fagundez on 11/8/15.
//  Copyright © 2015 Miguel Fagundez. All rights reserved.
//

import Foundation
import CoreData

@objc(ChoreLogMO)
class ChoreLogMO: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    override var description : String {
        return "(\(person_who_did_it!)) (\(chore_done!)) (\(when!))"
    }
}
