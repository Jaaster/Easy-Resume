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
        
        switch whatType(exam: exam) {
        case .normal:
            firebaseService.updateData(forResume: resume.resumeName, value: exam, with: data)
        case .employment:
        // update data for employment
            if let currentEmployment = resume.currentEmployment {
                firebaseService.updateData(forResume: resume.resumeName, employment: currentEmployment.companyName!, value: exam, with: data)
            } else {
                let employment = EmploymentModel(context: context)
                employment.companyName = data
                resume.currentEmployment = employment
                firebaseService.updateData(forResume: resume.resumeName, employment: employment.companyName!, value: exam, with: data)
            }
            
        case .education:
            // Update data for education
            if let currentEducation = resume.currentEducation {
                firebaseService.updateData(forResume: resume.resumeName, education: currentEducation.schoolName!, value: exam, with: data)
            } else {
                var education = EducationModel(context: context)
                education.schoolName = data
                resume.currentEducation = education
                firebaseService.updateData(forResume: resume.resumeName, education: education.schoolName!, value: exam, with: data)
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
        case .schoolName, .educationLevel, .specificFieldOfStudy, .educationRecord, .educationDescription:
            return DataType.education
        default:
            return DataType.normal
        }
    }
}
