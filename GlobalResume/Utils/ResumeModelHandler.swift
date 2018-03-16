//
//  ResumeModelHandler.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 3/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import CoreData

struct ResumeModelHandler {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).context
    
    func readModels<T: NSManagedObject>(type: T, sortDescriptor: [NSSortDescriptor]?, predicate: NSPredicate?) -> [T] {
        let fetchRequest: NSFetchRequest<T>!
        
        if T() is ResumeModel {
            fetchRequest = NSFetchRequest<T>(entityName: "ResumeModel")
        } else if T() is EducationModel {
            fetchRequest = NSFetchRequest<T>(entityName: "EducationModel")
        } else if T() is EmploymentModel {
            fetchRequest = NSFetchRequest<T>(entityName: "EmploymentModel")
        } else {
            fetchRequest = nil
        }
        
        fetchRequest.sortDescriptors = sortDescriptor
        fetchRequest.predicate = predicate
        var result = [T]()
        do {
            let data = try context.fetch(fetchRequest)
            result += data
        } catch {
            print(error.localizedDescription)
        }
       
        return result
    }
    
    func createResume(resumeName: String) -> Bool {
        
        if alreadyHasResume(withResumeName: resumeName) {
            return false
        } else {
            let resumeModel = ResumeModel(context: context)
            resumeModel.name = resumeName
            try? context.save()
            return true
        }
    }
    
    func alreadyHasResume(withResumeName: String) -> Bool {
        let predicateForSpecificName = NSPredicate(format: "resumeName = %@", withResumeName)
        return !readModels(type: ResumeModel(), sortDescriptor: nil, predicate: predicateForSpecificName).isEmpty
    }

    func updateModelsFromDataBase(data: [String : AnyObject]) {
        let firebaseConverter = FirebaseDataParser()

        for firebaseResume in firebaseConverter.convertDataToResumeModels(data: data) {
            if let firebaseResume = firebaseResume  {
                if alreadyHasResume(withResumeName: firebaseResume.resumeName!) {
                    // Allow firebase resume to update resumes in context
                    let predicate = NSPredicate(format: "resumeName = %@", firebaseResume.resumeName!)
                    let resumesWithName: [ResumeModel] = readModels(type: ResumeModel(), sortDescriptor: nil, predicate: predicate)
                    //transfer values to resume in the main context
                    for coreDataResume in resumesWithName {
                        
                        copyAttributes(ofResume: firebaseResume, toResume: coreDataResume)
                        
                        for model in firebaseResume.educationModels! {
                            if let firebaseEducation = model as? EducationModel {
                                /// Which education should be set?
                                copyAttributes(ofEducation: firebaseEducation, toResume: coreDataResume)
                            }
                        }
                        
                        for model in firebaseResume.employmentModels! {
                            if let firebaseEmployment = model as? EmploymentModel {
                                copyAttributes(ofEmployment: firebaseEmployment, toResume: coreDataResume)
                            }
                        }
                    }
                } else {
                    // Add resume to context
                    let coreDataResume = ResumeModel(context: context)
                    copyAttributes(ofResume: firebaseResume, toResume: coreDataResume)
                }
            }
        }
        
        do {
            if context.hasChanges {
                try context.save()
                print("saved context")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func copyAttributes(ofEducation: EducationModel, toResume: ResumeModel) {
        let entity = ofEducation.entity

        let educationModels = toResume.educationModels
        
        /// Create new Education Model and set values
        if educationModels?.count == 0 {
            let newEducationModel = EducationModel(context: context)
            
            for key in newEducationModel.entity.attributesByName.keys {
                newEducationModel.setValue(ofEducation.value(forKey: key), forKey: key)
            }
            
            toResume.addToEducationModels(newEducationModel)
            return
        }
        
        // already has models so update the values
        for model in educationModels! {
            if let educationModel = model as? EducationModel {
            if let name = ofEducation.schoolName, let name1 = educationModel.schoolName {
                    // Is same model
                    if name == name1 {
                        for key in entity.attributesByName.keys {
                            educationModel.setValue(ofEducation.value(forKey: key), forKey: key)
                        }
                    }
                }
            }
        }
    }
    
    private func copyAttributes(ofEmployment: EmploymentModel, toResume: ResumeModel) {
        let entity = ofEmployment.entity
        
        let employmentModels = toResume.employmentModels
        
        if employmentModels?.count == 0 {
            let newEmploymentModel = EmploymentModel(context: context)
            
            for key in newEmploymentModel.entity.attributesByName.keys {
                newEmploymentModel.setValue(ofEmployment.value(forKey: key), forKey: key)
            }
            
            toResume.addToEmploymentModels(newEmploymentModel)
            return
        }
        
        for model in employmentModels! {
            if let employmentModel = model as? EmploymentModel {
                if let name = ofEmployment.companyName, let name1 = employmentModel.companyName {
                    // Is same model
                    if name == name1 {
                        for key in entity.attributesByName.keys {
                            employmentModel.setValue(ofEmployment.value(forKey: key), forKey: key)
                        }
                    }
                }
            }
        }
    }
    
    private func copyAttributes(ofResume: ResumeModel, toResume: ResumeModel) {
        let entity = ofResume.entity
        for key in entity.attributesByName.keys {
            let value = ofResume.value(forKey: key)
            toResume.setValue(value, forKey: key)
        }
    }
    
    func contactInfoValues(ofResume: ResumeModel) -> [String] {
        var result = [String]()
        for propertyKey in ofResume.entity.propertiesByName.keys.filter({ $0 != "resumeName"}) {
            if let propertyValue = ofResume.value(forKey: propertyKey) as? String {
                result.append(propertyValue)
            }
        }
        return result
    }
    
    
    func employmentCompanyNames(ofResume: ResumeModel) -> [String] {
        var result = [String]()
        // Not returning any values
        guard let employmentModels = ofResume.employmentModels else { return []}
        for employmentModel in employmentModels {
            if let employmentModel = employmentModel as? EmploymentModel {
                if let name = employmentModel.companyName {
                    result.append(name)
                }
            }
        }
        return result
    }
    
    func educationSchoolNames(ofResume: ResumeModel) -> [String] {
        guard let educationModels = ofResume.educationModels else { return [] }
        var result = [String]()
        
        
        for model in educationModels {
            if let educationModel = model as? EducationModel {
                if let name = educationModel.schoolName {
                    result.append(name)
                }
            }
        }
        return result
    }
}
