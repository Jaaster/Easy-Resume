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
    private var currentEducation: Education?
    private var currentEmployment: Employment?
    
    var editingResume: Bool = false
    
    var creatingResume: Bool = false
    
    private init() {}
    
    
    func updateData(dataType: Exam, data: String) {
        
        if currentResume == nil {
            currentResume = ResumeData(context: PersistantService.context)
        }
        setValue(object: currentResume!, data: data, forKey: dataType.rawValue)
    }
    
    
    func updateData(for trigger: Trigger, exam: Exam, data: String) {
        if trigger.isEmployment() {
            if currentEmployment == nil {
                currentEmployment = Employment(context: PersistantService.context)
                if let currentResume = currentResume {
                    //Status's are always saved in the resume
                    setValue(object: currentResume, data: data, forKey: exam.rawValue)
                }
                return
            }
            setValue(object: currentEmployment!, data: data, forKey: exam.rawValue)

        } else if trigger.isEducation() {
            if currentEducation == nil {
                currentEducation = Education(context: PersistantService.context)
                if let currentResume = currentResume {
                    //Status's are always saved in the resume
                    setValue(object: currentResume, data: data, forKey: exam.rawValue)
                }
                return
            }
            setValue(object: currentEducation!, data: data, forKey: exam.rawValue)
        }
    }
    
    func setValue(object: NSManagedObject, data: String, forKey: String) {
        print(data)
        print(forKey)
        object.setValue(data, forKey: forKey.lowercased().replacingOccurrences(of: " ", with: "_"))
    }

    func gender() -> String {
        if let resume = currentResume {
            if let gender = resume.gender {
                return gender.capitalized
            }
        }
        return ""
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
    
    func editResume(resumeName: String) -> ResumeData? {
        editingResume = true
        //Get resume based off of title of resume
        //set currentResume to returned resume
        return nil
    }
    
    func getResumeList() -> [ResumeData]? {
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
    
}




