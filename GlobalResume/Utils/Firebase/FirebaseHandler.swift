//
//  FirebaseHandler.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/27/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation
import UIKit
struct FirebaseHandler {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).context

    func handleData(resume: ResumeData, exam: Exam, data: String) {
        let firebaseService = FIRFirebaseService()
        let id = resume.uid

        switch whatType(exam: exam) {
        case .normal:
            firebaseService.updateData(resumeID: id, value: exam, data: data)
        case .employment:
            // update data for employment
            guard let currentEmployment = resume.currentEmployment else {
                let employment = EmploymentModel(context: context)
                let employmentUID = UUID().uuidString
                employment.uid = employmentUID
                employment.companyName = data
                resume.currentEmployment = employment
                firebaseService.updateEmploymentData(resumeID: id, employmentID: employmentUID , value: exam, data: data)
                return
            }

            let resumeHandler = ResumeModelHandler()
            let predicate = NSPredicate(format: "uid == %@", currentEmployment.uid!)
            let models = resumeHandler.readModels(objectType: EmploymentModel(), sortDescriptor: nil, predicate: predicate)
            
            if let firstEmployment = models.first {
                //coverting coredata to json then saving that json on firebase
                guard let employmentID = firstEmployment.uid else {
                    print("EmploymentModel does not have a uid")
                    return
                    
                }
                firebaseService.updateEmploymentData(resumeID: resume.uid, employmentID: employmentID, value: exam, data: data)
            }
            
        case .education:
            // Update data for education
//            if let currentEducation = resume.currentEducation {
//                firebaseService.updateData(forResume: resume.resumeName, education: currentEducation.schoolName!, value: exam, with: data)
//            } else {
//                let education = EducationModel(context: context)
//                education.schoolName = data
//                resume.currentEducation = education
//                firebaseService.updateData(forResume: resume.resumeName, education: education.schoolName!, value: exam, with: data)
//            }
            break
        }
    }
    
    enum DataType {
        case normal
        case employment
        case education
    }
    
}

private extension FirebaseHandler {
    
    func whatType(exam: Exam) -> DataType {
        switch exam {
        case .employmentRecord, .jobTitle, .jobDescription, .companyName:
            return DataType.employment
        case .schoolName, .educationLevel, .specificFieldOfStudy, .educationRecord, .educationDescription:
            return DataType.education
        default:
            return DataType.normal
        }
    }
}
