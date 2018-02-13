//
//  ResumeDataService.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/11/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import CoreData
import Foundation
// MARK: - ResumeDataService should only be accessed from ResumeDataHandler
final class ResumeDataService {
    private let context = PersistantService.context
    private let saveContext = PersistantService.saveContext()
}
// MARK: - public Data altering functions
extension ResumeDataService {
    // MARK: - Updates the variable(key) for resume(object) with data(String) and then saves context
    func updateData(for resume: ResumeData, with data: String, for key: Exam) {
        setValue(object: resume, data: data, for: key.rawValue)
        saveContext
    }
    
    // MARK: - Creates and returns a ResumeData
    func createResume() -> ResumeData {
        let resume = ResumeData(context: context)
        return resume
    }
    
    // MARK: - Deletes the passed in ResumeData from the Context
    func delete(resume: ResumeData) {
        PersistantService.context.delete(resume)
    }
    
    // MARK: - Updates the data of an existant ResumeData
    func put(employment: Employment?, education: Education?, in resume: ResumeData) {
        
        if let education = education {
            resume.addToEducation(education)
        }
        
        if let employment = employment {
            resume.addToEmployment(employment)
        }
    }
}

// MARK: - Getter functions
extension ResumeDataService {
    func getCoreDataResumeList() -> [ResumeData]? {
        //Grab data from coredata
        do {
            let list = try context.fetch(ResumeData.fetchRequest())
            if let resumeList = list as? [ResumeData] {
                if !resumeList.isEmpty {
                    return resumeList
                }
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        return nil
    }
}
// MARK: - Private functions
private extension ResumeDataService {
    
    // MARK: - Sets the value for the specific object and key
    func setValue(object: NSManagedObject, data: String, for key: String) {
        var newKey = key
        // MARK: - Every Attribute of passed in object is lowercased and used snake-case
        // Before JOB TITLE after job title
        newKey = newKey.lowercased()
        //Before job title after job_title
        newKey = newKey.replacingOccurrences(of: " ", with: "_")
        
        object.setValue(data, forKey: key)
    }
}
