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
    
    func readModels<T: NSManagedObject>(objectType: T, sortDescriptor: [NSSortDescriptor]?, predicate: NSPredicate?) -> [T] {
        let fetchRequest: NSFetchRequest<T>!
        
        let nameOfType = NSStringFromClass(type(of: objectType))
        fetchRequest = NSFetchRequest<T>(entityName: nameOfType)
        
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
                    continue
                }
                
                let getResumesWithUID = NSPredicate(format: "uid == %@", firebaseUID)
                let coreDataResumes: [ResumeModel] = readModels(objectType: ResumeModel(), sortDescriptor: nil, predicate: getResumesWithUID)
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
                copyAttributes(ofModels: employmentModels, toResume: coreDataResume)
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
    
    private func copyAttributes<T: UIDable>(ofModels: [T], toResume: ResumeModel) {
        
        for ofModel in ofModels {
            let keys = ofModel.entity.attributesByName.keys
            let newModel: T!
            if let uid = ofModel.getUID() {
                if let model = relationshipModel(uid: uid, type: T()) {
                    newModel = model
                    print("model")
                    print(model)
                } else {
                    print("new model")
                    newModel = T(context: context)
                  
                }
                
                if let newModel = newModel as? EmploymentModel {
                    toResume.addToEmploymentModels(newModel)
                } else if let newModel = newModel as? EducationModel {
                    toResume.addToEducationModels(newModel)
                }
                
            } else {
                continue
            }
            
            for key in keys {
                newModel.setValue(ofModel.value(forKey: key), forKey: key)
            }
        }
    }
    
    private func relationshipModel<T: NSManagedObject>(uid: String, type: T) -> T? {
        let predicate = NSPredicate(format: "uid == %@", uid)
        let values = readModels(objectType: T(), sortDescriptor: nil, predicate: predicate)
        return values.first
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
    
    func contactInfoValues(ofResume: ResumeModel, filter elements: [String]) -> [(title: String, description: String)] {
        var result = [(String, String)]()
        for propertyKey in ofResume.entity.propertiesByName.keys.filter({!elements.contains($0)}) {
            let description = propertyKey.titleCase
            if ofResume.value(forKey: propertyKey) is String? {
                if let propertyValue = ofResume.value(forKey: propertyKey) {
                    result.append((propertyValue as! String, description))
                } else {
                    result.append(("", description))
                }
            } else {
                // Key most likely is toResume( a relationship of ResumeModel) do nothing, however may need to change this in the future for employmeny models that do not have all of their values
            }
          
        }
        return result
    }
    
    func employmentCompanyNames(ofResume: ResumeModel) -> [(title: String, description: String)] {
        var result = [(String, String)]()
        guard let employmentModels = ofResume.employmentModels else { return []}
        for employmentModel in employmentModels {
            if let employmentModel = employmentModel as? EmploymentModel {
                if let name = employmentModel.companyName {
                    result.append((name, ""))
                }
            }
        }
        
        return result
    }
    
    func employmentValues(ofEmployment: EmploymentModel?, filter elements: [String]) -> [(title: String, description: String)] {
        guard let ofEmployment = ofEmployment else { return []}
        var result = [(String, String)]()
        for propertyKey in ofEmployment.entity.propertiesByName.keys.filter({ !elements.contains($0)}) {
            let description = propertyKey.titleCase
            if ofEmployment.value(forKey: propertyKey) is String? {
                if let propertyValue = ofEmployment.value(forKey: propertyKey) {
                    result.append((propertyValue as! String, description))
                } else {
                    result.append(("", description))
                }
            } else {
                // Key most likely is toResume( a relationship of ResumeModel) do nothing, however may need to change this in the future for employmeny models that do not have all of their values
            }
        }
        return result
    }
    
    func educationSchoolNames(ofResume: ResumeModel) -> [(title: String, description: String)] {
        guard let educationModels = ofResume.educationModels else { return [] }
        var result = [(String, String)]()
        
        
        for model in educationModels {
            if let educationModel = model as? EducationModel {
                if let name = educationModel.schoolName {
                    result.append((name, ""))
                }
            }
        }
        return result
    }
}
