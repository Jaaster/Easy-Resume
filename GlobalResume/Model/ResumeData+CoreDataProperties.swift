//
//  ResumeData+CoreDataProperties.swift
//  
//
//  Created by Joriah Lasater on 1/30/18.
//
//

import Foundation
import CoreData


extension ResumeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResumeData> {
        return NSFetchRequest<ResumeData>(entityName: "ResumeData")
    }

    @NSManaged public var resume_name: String?

    
    @NSManaged public var email: String?
    @NSManaged public var employment_status: String?
    @NSManaged public var education_status: String?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    @NSManaged public var phone_number: String?
    @NSManaged public var zip_code: String?
    @NSManaged public var education: NSSet?
    @NSManaged public var employment: NSSet?

}

// MARK: Generated accessors for education
extension ResumeData {

    @objc(addEducationObject:)
    @NSManaged public func addToEducation(_ value: Education)

    @objc(removeEducationObject:)
    @NSManaged public func removeFromEducation(_ value: Education)

    @objc(addEducation:)
    @NSManaged public func addToEducation(_ values: NSSet)

    @objc(removeEducation:)
    @NSManaged public func removeFromEducation(_ values: NSSet)

}

// MARK: Generated accessors for employment
extension ResumeData {

    @objc(addEmploymentObject:)
    @NSManaged public func addToEmployment(_ value: Employment)

    @objc(removeEmploymentObject:)
    @NSManaged public func removeFromEmployment(_ value: Employment)

    @objc(addEmployment:)
    @NSManaged public func addToEmployment(_ values: NSSet)

    @objc(removeEmployment:)
    @NSManaged public func removeFromEmployment(_ values: NSSet)

}
