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
    
    func updateModelsFromDataBase(data: [String : AnyObject]) {
        
        
        // Do I have a uid that matches one on the device?
        // If not create a new one, otherwise update the device to the data on the firebase.
        
        
        let firebaseConverter = FirebaseDataParser()
        
        for firebaseResume in firebaseConverter.convertDataToResumeModels(data: data) {
            if let firebaseResume = firebaseResume  {
                
                guard let firebaseUID = firebaseResume.uid else {
                    // Add resume to context
                    let coreDataResume = ResumeModel(context: context)
                    // TODO update data in firebase
                    coreDataResume.uid = UUID().uuidString
                    copyAttributes(ofResume: firebaseResume, toResume: coreDataResume)
                    return
                }
                
                let getResumesWithUID = NSPredicate(format: "uid = %@", firebaseUID)
                let coreDataResumes: [ResumeModel] = readModels(type: ResumeModel(), sortDescriptor: nil, predicate: getResumesWithUID)
                var coreDataResume: ResumeModel!
                
                if coreDataResumes.isEmpty {
                    // Create new resume
                    coreDataResume = ResumeModel(context: context)
                } else {
                    // Get coreDataResume that correlates with the firebaseResume
                    if let resume = coreDataResumes.first {
                        coreDataResume = resume
                    }
                }
                // Handle the updates here
                var educationModels = [EducationModel]()
                var employmentModels = [EmploymentModel]()
                
                firebaseResume.educationModels?.forEach { if let educationModel = $0 as? EducationModel {
                    educationModels.append(educationModel)
                    }
                }
                
                firebaseResume.employmentModels?.forEach { if let employmentModel = $0 as? EmploymentModel {
                    employmentModels.append(employmentModel)
                    }
                }
                
                copyAttributes(ofResume: firebaseResume, toResume: coreDataResume)
                copyAttributes(ofEmploymentModels: employmentModels, toResume: coreDataResume)
                copyAttributes(ofEducationModels: educationModels, toResume: coreDataResume)
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
    
    private func copyAttributes(ofEmploymentModels: [EmploymentModel], toResume: ResumeModel) {
        
        let toResumeEmploymentModels = toResume.employmentModels
        for ofEmploymentModel in ofEmploymentModels {
            let entity = ofEmploymentModel.entity
            
            /// Create new Education Model and set values
            if toResumeEmploymentModels?.count == 0 {
                let newEmploymentModel = EmploymentModel(context: context)
                
                for key in entity.attributesByName.keys {
                    newEmploymentModel.setValue(ofEmploymentModel.value(forKey: key), forKey: key)
                }
                
                toResume.addToEmploymentModels(newEmploymentModel)
                return
            }
            
            
            // already has models so update the values
            for model in toResumeEmploymentModels! {
                if let employmentModel = model as? EmploymentModel {
                    if ofEmploymentModel.uid == employmentModel.uid {
                        // Is same model
                        for key in entity.attributesByName.keys {
                            employmentModel.setValue(ofEmploymentModel.value(forKey: key), forKey: key)
                        }
                    }
                }
            }
        }
    }
    
    private func copyAttributes(ofEducationModels: [EducationModel], toResume: ResumeModel) {
        
        
        let toResumeEducationModels = toResume.educationModels
        for ofEducationModel in ofEducationModels {
            let entity = ofEducationModel.entity
            
            /// Create new Education Model and set values
            if toResumeEducationModels?.count == 0 {
                let newEducationModel = EducationModel(context: context)
                
                for key in entity.attributesByName.keys {
                    newEducationModel.setValue(ofEducationModel.value(forKey: key), forKey: key)
                }
                
                toResume.addToEducationModels(newEducationModel)
                return
            }
            
            
            // already has models so update the values
            for model in toResumeEducationModels! {
                if let educationModel = model as? EducationModel {
                    if ofEducationModel.schoolName == educationModel.schoolName {
                        // Is same model
                        for key in entity.attributesByName.keys {
                            educationModel.setValue(ofEducationModel.value(forKey: key), forKey: key)
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
}

/// Get values for UI display from models
extension ResumeModelHandler {
    
    func contactInfoValues(ofResume: ResumeModel, filter elements: [String]) -> [String] {
        var result = [String]()
        for propertyKey in ofResume.entity.propertiesByName.keys.filter({!elements.contains($0)}) {
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
    
    
    func employmentValues(ofEmployment: EmploymentModel?, filter elements: [String]) -> [String] {
        guard let ofEmployment = ofEmployment else { return []}
        var result = [String]()
        for key in ofEmployment.entity.propertiesByName.keys.filter({ !elements.contains($0)}) {
            if let value = ofEmployment.value(forKey: key) as? String {
                result.append(value)
            } else {
                // Key most likely is toResume do nothing, however may need to change this in the future for employmeny models that do not have all of their values
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
