//
//  Trigger.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/19/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

enum Trigger: String {
    
    case employed = "EMPLOYED"
    case unemployed = "UNEMPLOYED"
    
    case inSchool = "IN SCHOOL"
    case graduated = "GRADUATED"
    
    func allValues() -> [Trigger] {
        return [.employed, .unemployed, .inSchool, .graduated]
    }
    
    //If a nil value is passed it returns the first exam of examList
    func next(exam: Exam?) -> Exam? {
        let list = examList()

        if let exam = exam {
            
            if !list.contains(exam) {
                return nil
            }
            
            let nextIndex = list.index(of: exam)! + 1
            
            if list.count > nextIndex {
                return list[nextIndex]
            }
            return nil
        }
        return list.first
        
    }
    //Can edit what Exams come after the Trigger
    private func examList() -> [Exam] {
        switch self {
        case .employed, .unemployed:
            return [.companyName, .jobTitle, .jobDescription, .employmentRecord]
        case .inSchool, .graduated:
            return [.schoolName, .specificFieldOfStudy, .educationLevel, .educationDescription, .educationRecord]
        }
        
    }
    
    func isEmployment() -> Bool {
        if self == .employed || self == .unemployed {
            return true
        }
        return false
    }
    
    func isEducation() -> Bool {
        if self == .graduated || self == .inSchool {
            return true
        }
        return false
    
    }
    
    func isFirst(exam: Exam) -> Bool {
        return examList().first! == exam
    }
}

