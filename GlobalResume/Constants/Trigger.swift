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
    
    func allValues() -> [Trigger] {
        return [.employed, .unemployed]
    }
    
    func isTriggered() -> Bool {
        return OneInstance.shared.isTriggered
    }
    
    //If a nil value is passed it returns the first exam of examList
    func next(exam: Exam?) -> Exam? {
        
        if let exam = exam {
            
            let nextIndex = examList().index(of: exam)! + 1
            
            if examList().count > nextIndex {
                return examList()[nextIndex]
                
            }
            return nil
        }
        return examList().first
        
    }
    //Can edit what Exams come after the Trigger
    func examList() -> [Exam] {
        switch self {
        case .employed, .unemployed:
            return [Exam.employmentRecord]
            
        }
        
    }
    
    func isFirst(exam: Exam) -> Exam? {
        if examList().first == exam {
            return exam
        }
        return nil
    }
}

