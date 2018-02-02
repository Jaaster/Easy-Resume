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
    
    @NSManaged public var education_level: String?
    @NSManaged public var education_record: String?
    @NSManaged public var field_of_study: String?
    @NSManaged public var school_name: String?

}
