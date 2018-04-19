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
            guard let uid = resume.currentEmployment?.uid else {
                let newUid = UUID().uuidString
                let newEmploymentModel = EmploymentModel(context: context)
                newEmploymentModel.uid = newUid
                newEmploymentModel.companyName = data
                resume.currentEmployment = newEmploymentModel
                firebaseService.updateEmploymentData(resumeID: id, employmentID: newUid , value: exam, data: data)
                return
            }
            // update data for employment
            let resumeHandler = ResumeModelHandler()
            let predicate = NSPredicate(format: "uid == %@", uid)
            let models = resumeHandler.readModels(objectType: EmploymentModel(), sortDescriptor: nil, predicate: predicate)
            
            if !models.isEmpty {
                firebaseService.updateEmploymentData(resumeID: resume.uid, employmentID: uid, value: exam, data: data)
            }
            
        case .education:
            guard let uid = resume.currentEducation?.uid else {
                let newUid = UUID().uuidString
                let newEducationModel = EducationModel(context: context)
                newEducationModel.uid = newUid
                newEducationModel.schoolName = data
                resume.currentEducation = newEducationModel
                firebaseService.updateEducationData(resumeID: id, educationID: newUid , value: exam, data: data)
                return
            }
            // update data for employment
            let resumeHandler = ResumeModelHandler()
            let predicate = NSPredicate(format: "uid == %@", uid)
            let models = resumeHandler.readModels(objectType: EducationModel(), sortDescriptor: nil, predicate: predicate)
            
            if !models.isEmpty {
                firebaseService.updateEducationData(resumeID: resume.uid, educationID: uid, value: exam, data: data)
            }
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
        case .schoolName, .educationLevel, .fieldOfStudy, .educationRecord, .educationDescription:
            return DataType.education
        default:
            return DataType.normal
        }
    }
}
