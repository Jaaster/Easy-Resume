//
//  ResumeData.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import CoreData

class ResumeDataHandler {
    
    static let shared = ResumeDataHandler()
    
    var currentResume: ResumeData?
    var currentEducation: Education?
    var currentEmployment: Employment?
    var isEditingResume: Bool = false
    var creatingResume: Bool = false
    
    private init() {}
    
    func updateData(dataType: Exam, data: String) {
        guard let currentResume = currentResume else {
            self.currentResume = ResumeData(context: PersistantService.context)
            return
        }
        setValue(object: currentResume, data: data, forKey: dataType.rawValue)
    }
    
    func updateData(for trigger: Trigger, exam: Exam, data: String) {
        if trigger.isEmployment() {
            guard let currentEmployment = currentEmployment else {
                self.currentEmployment = Employment(context: PersistantService.context)
                
                if let currentResume = currentResume {
                    //Status is always saved in the resume
                    setValue(object: currentResume, data: data, forKey: exam.rawValue)
                }
                return
            }
        
            setValue(object: currentEmployment, data: data, forKey: exam.rawValue)
            
        } else if trigger.isEducation() {
            guard let currentEducation = currentEducation else {
                self.currentEducation = Education(context: PersistantService.context)
                if let currentResume = currentResume {
                    //Status is always saved in the resume
                    setValue(object: currentResume, data: data, forKey: exam.rawValue)
                }
                return
            }
            setValue(object: currentEducation, data: data, forKey: exam.rawValue)
        }
    }
    
    private func setValue(object: NSManagedObject, data: String, forKey: String) {
        object.setValue(data, forKey: forKey.lowercased().replacingOccurrences(of: " ", with: "_"))
    }

    func gender() -> Gender {
        return Gender(rawValue: currentResume!.gender!)!
    }
    
    func putEmploymentAndEducationInResume() {
        //Save data and set the variables in the class to the updated
        if let currentResume = currentResume {
            if let currentEducation = currentEducation {
                currentResume.addToEducation(currentEducation)
                self.currentEducation = nil
            }
            
            if let currentEmployment = currentEmployment {
                currentResume.addToEmployment(currentEmployment)
                self.currentEmployment = nil
            }
        }
    }
    
    func getCoreDataResumeList() -> [ResumeData]? {
        //Grab data from coredata
        do {
            let list = try PersistantService.context.fetch(ResumeData.fetchRequest())
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
    
    func employment(from index: Int) -> Employment {
        let eList = currentResume?.employment?.allObjects as! [Employment]
        return eList[index]
    }
    
    func education(from index: Int) -> Education {
        let eList = currentResume?.education?.allObjects as! [Education]
        return eList[index]
    }
}
