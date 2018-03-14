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
    
    func readResumeModels(sortDescriptor: [NSSortDescriptor]?, predicate: NSPredicate?) -> [ResumeModel] {
        let fetchRequest: NSFetchRequest<ResumeModel> = ResumeModel.fetchRequest()
        fetchRequest.sortDescriptors = sortDescriptor
        fetchRequest.predicate = predicate
        var result = [ResumeModel]()
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
        return !readResumeModels(sortDescriptor: nil, predicate: predicateForSpecificName).isEmpty
    }

    func updateModelsFromDataBase(data: [String : AnyObject]) {
        let firebaseConverter = FirebaseDataParser()

        for firebaseResume in firebaseConverter.convertDataToResumeModels(data: data) {
            if let firebaseResume = firebaseResume  {
                if alreadyHasResume(withResumeName: firebaseResume.resumeName!) {
                    // Allow firebase resume to update resumes in context
                    let predicate = NSPredicate(format: "resumeName = %@", firebaseResume.resumeName!)
                    let resumesWithName = readResumeModels(sortDescriptor: nil, predicate: predicate)
                    //transfer values to resume in the main context
                    for coreDataResume in resumesWithName {
                        
                        copyAttributes(ofResume: firebaseResume, toResume: coreDataResume)
                        
                        for firebaseEducation in firebaseResume.educationModels! {
                            if let firebaseEducation = educationModel as? EducationModel {
                                copyAttributes(ofEducation: educationModel, toEducation: r.ed)
                            }
                        }
                        copyAttributes(ofEducation: <#T##EducationModel#>, toEducation: <#T##EducationModel#>)
                    }
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
    
    private func copyAttributes(ofEducation: EducationModel, toEducation: EducationModel) {
        let entity = ofEducation.entity
        for key in entity.attributesByName.keys {
            let value = ofEducation.value(forKey: key)
            toEducation.setValue(value, forKey: key)
        }
    }
    
    private func copyAttributes(ofEmployment: EmploymentModel, toEmployment: EmploymentModel) {
        let entity = ofEmployment.entity
        for key in entity.attributesByName.keys {
            let value = ofEmployment.value(forKey: key)
            toEmployment.setValue(value, forKey: key)
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
