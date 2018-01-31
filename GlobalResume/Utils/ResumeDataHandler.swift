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
    
    private var currentResume: ResumeData?
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
        object.setValue(data, forKey: forKey.lowercased().replacingOccurrences(of: " ", with: "_"))
    }

    func getData(forKey: Exam) -> String {
        return "String"
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
}




