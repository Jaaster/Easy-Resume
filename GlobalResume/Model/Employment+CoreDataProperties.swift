//
//  Employment+CoreDataProperties.swift
//  
//
//  Created by Joriah Lasater on 1/30/18.
//
//

import Foundation
import CoreData


extension Employment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employment> {
        return NSFetchRequest<Employment>(entityName: "Employment")
    }

    @NSManaged public var company_name: String?
    @NSManaged public var endDate: NSDate?
    @NSManaged public var job_description: String?
    @NSManaged public var job_title: String?
    @NSManaged public var startDate: NSDate?

}
