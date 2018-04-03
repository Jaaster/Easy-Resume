//
//  NSManagedObjectsExtensions.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 3/14/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import CoreData
protocol UIDable where Self: NSManagedObject {
    func getUID() -> String?
}

extension ResumeModel: UIDable {
    func getUID() -> String? {
        return uid
    }
}
extension EducationModel: UIDable {
    func getUID() -> String? {
        return uid
    }
}
extension EmploymentModel: UIDable {
    func getUID() -> String? {
        return uid
    }
}
