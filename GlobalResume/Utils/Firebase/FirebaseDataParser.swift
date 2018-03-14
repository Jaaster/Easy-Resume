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
    
    let context: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        context.parent = (UIApplication.shared.delegate as! AppDelegate).context
        return context
    }()
    
    func convertDataToResumeModels(data: [String : AnyObject]) -> [ResumeModel?] {
        var result = Array<ResumeModel?>(repeating: nil, count: data.count)
        
        for (index, element) in data.enumerated() {
            if let value = element.value as? [String : AnyObject] {
                let resume = resumeModelFrom(data: value)
                result[index] = resume
            }
        }
        return result
    }
    
}

private extension FirebaseDataParser {
    
    func resumeModelFrom(data: [String : AnyObject]) -> ResumeModel {
        let model = ResumeModel(context: context)
        let employmentKey = FIRDataReferencePath.employment.rawValue
        let educationKey = FIRDataReferencePath.education.rawValue
        for (key, value) in data {
            if key == employmentKey {
                if let newData = data[key] as? [String : AnyObject] {
                    //EmplomentModels
                    let employmentModels = employmentModelsFrom(data: newData)
                    for eModel in employmentModels {
                        if let eModel = eModel {
                            model.addToEmploymentModels(eModel)
                        }
                    }
                }
            } else if key == educationKey {
                if let newData = data[key] as? [String : AnyObject] {
                    //EducationModels
                    let educationModels = educationModelsFrom(data: newData)
                    for eModel in educationModels {
                        if let eModel = eModel {
                            model.addToEducationModels(eModel)
                        }
                    }
                }
            } else {
                // ResumeModel Values
                model.setValue(value, forKey: key.camelCase!)
            }
        }
        return model
    }
    
    func educationModelsFrom(data: [String : AnyObject]) -> [EducationModel?] {
        var result = Array<EducationModel?>(repeating: nil, count: data.count)
        for (index, element) in data.enumerated() {
            if let data = element.value as? [String : AnyObject] {
                result[index] = educationModelFrom(data: data)
            }
        }
        return result
    }
    
    func employmentModelsFrom(data: [String : AnyObject]) -> [EmploymentModel?] {
        var result = Array<EmploymentModel?>(repeating: nil, count: data.keys.count)
        
        for (index, element) in data.enumerated() {
            if let data = element.value as? [String : AnyObject] {
                result[index] = employmentModelFrom(data: data)
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
    
    func employmentModelFrom(data: [String : AnyObject]) -> EmploymentModel {
        let result = EmploymentModel(context: context)
        for (key, value) in data {
            let key = key.camelCase!
            result.setValue(value, forKey: key)
        }
        return result
    }
}
