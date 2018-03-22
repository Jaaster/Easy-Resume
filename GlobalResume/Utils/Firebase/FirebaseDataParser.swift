//
//  FirebaseDataConverter.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 3/11/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct FirebaseDataParser {
    
    // UUID for all models are the last ref child
    
    
    let context: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        context.parent = (UIApplication.shared.delegate as! AppDelegate).context
        return context
    }()
    
    func convertDataToResumeModels(data: [String : AnyObject]) -> [ResumeModel?] {
        var result = Array<ResumeModel?>(repeating: nil, count: data.count)
        
        for (index, element) in data.enumerated() {
            if let value = element.value as? [String : AnyObject] {
                let uid = element.key
                let resume = resumeModelFrom(resumeID: uid, data: value)
                result[index] = resume
            }
        }
        return result
    }
    
}

private extension FirebaseDataParser {
    
    func resumeModelFrom(resumeID: String, data: [String : AnyObject]) -> ResumeModel {
        let resumeModel = ResumeModel(context: context)
        resumeModel.uid = resumeID
        
        let employmentKey = FIRDataReferencePath.employment.rawValue
        let educationKey = FIRDataReferencePath.education.rawValue
        for (key, value) in data {
            if key == employmentKey {
                if let newData = data[key] as? [String : AnyObject] {
                    //EmplomentModels
                    let employmentModels = employmentModelsFrom(data: newData)
                    for eModel in employmentModels {
                        if let eModel = eModel {
                            resumeModel.addToEmploymentModels(eModel)
                        }
                    }
                }
            } else if key == educationKey {
                if let newData = data[key] as? [String : AnyObject] {
                    //EducationModels
                    let educationModels = educationModelsFrom(data: newData)
                    for eModel in educationModels {
                        if let eModel = eModel {
                            resumeModel.addToEducationModels(eModel)
                        }
                    }
                }
            } else {
                // ResumeModel Values
                resumeModel.setValue(value, forKey: key.camelCase!)
            }
        }
        
        for e in resumeModel.entity.propertiesByName.keys {
            print("property: \(e)  ||  value: \(resumeModel.value(forKey: e))")
        }
        
        return resumeModel
    }
    
    func educationModelsFrom(data: [String : AnyObject]) -> [EducationModel?] {
//        var result = Array<EducationModel?>(repeating: nil, count: data.count)
//        for (index, element) in data.enumerated() {
//            if let data = element.value as? [String : AnyObject] {
//                result[index] = educationModelFrom(data: data)
//            }
//        }
//        return result
        return []
    }
    
    func employmentModelsFrom(data: [String : AnyObject]) -> [EmploymentModel?] {
        var result = Array<EmploymentModel?>(repeating: nil, count: data.keys.count)

        for (index, element) in data.enumerated() {
            if let data = element.value as? [String : AnyObject] {
                let uid = element.key
                result[index] = employmentModelFrom(employmentModelID: uid, data: data)
                
            }
        }
        return result
    }
    
    func educationModelFrom(data: [String : AnyObject]) -> EducationModel {
        let result = EducationModel(context: context)
        for (key, value) in data {
            let key = key.camelCase!
            result.setValue(value, forKey: key)
        }
        return result
    }
    
    func employmentModelFrom(employmentModelID: String, data: [String : AnyObject]) -> EmploymentModel {
        let result = EmploymentModel(context: context)
        result.uid = employmentModelID
        for (key, value) in data {
            let key = key.camelCase!
            result.setValue(value, forKey: key)
        }
        return result
    }
}
