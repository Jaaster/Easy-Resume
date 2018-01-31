//
//  Education+CoreDataProperties.swift
//  
//
//  Created by Joriah Lasater on 1/30/18.
//
//

import Foundation
import CoreData


extension Education {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Education> {
        return NSFetchRequest<Education>(entityName: "Education")
    }

    @NSManaged public var educationLevel: String?
    @NSManaged public var endDate: NSDate?
    @NSManaged public var fieldOfStudy: String?
    @NSManaged public var schoolName: String?
    @NSManaged public var startDate: NSDate?

}
