//
//  Exam.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

enum Exam: String {
    //Standard
    case menu = "MENU"
    case name = "NAME"
    case gender = "GENDER"
    case email = "EMAIL"
    case number = "PHONE NUMBER"
    case zipcode = "ZIP CODE"
    
    //Employment
    case employmentStatus = "EMPLOYMENT STATUS"
    
    case employmentRecord = "EMPLOYMENT RECORD"
    case jobTitle = "JOB TITLE"
    case jobDescription = "JOB DESCRIPTION"
    case companyName = "COMPANY NAME"

    //Education
    case educationStatus = "EDUCATION STATUS"

    case schoolName = "SCHOOL NAME"
    case educationLevel = "EDUCATION LEVEL"
    case specificFieldOfStudy = "FIELD OF STUDY"
    case educationRecord = "EDUCATION RECORD"
    
    
    case resumeName = "RESUME NAME"
    
    enum Kind: String {
        case main = "MAIN"
        case input = "INPUT"
        case description = "DESCRIPTION"
        case twoButtons = "TWO_BUTTONS"
        case threeBarButtons = "THREE_BAR_BUTTONS"
        case twoBarButtons = "TWO_BAR_BUTTONS"
        static func get(from string: String) -> Kind? {
            return Kind(rawValue: string)
            
        }
        
    }
    
    
    func getValues() -> (kind: Kind, example: String, color: Color, buttons: [(name: String, color: Color)]){
        switch self {
        case .name:
            return (.input, "e.g Jerry Springer", Color.pink, [])
        case .gender:
            return (.twoButtons,"", Color.clear, [("MALE", Color.blue), ("FEMALE", Color.pink)])
        case .email:
            return (.input, "example@gmail.com", Color.blue, [])
        case .number:
            return (.input,"e.g 1 (931) 390 3949", Color.grey, [])
        case .zipcode:
            return (.input, "e.g 37052", Color.grey, [])
        case .employmentStatus:
            return (.threeBarButtons, "", Color.grey, [("EMPLOYED", Color.grey), ("UNEMPLOYED", Color.grey), ("NO HISTORY", Color.grey)])
        case .menu:
            return (.main, "", Color.clear, [])
        case .companyName:
            return (.input, "e.g Apple", Color.grey, [])
        case .jobTitle:
            return (.input, "e.g Manager", Color.grey, [])
        case .employmentRecord:
            return (.twoBarButtons, "", Color.grey, [("START", Color.grey), ("END", Color.grey)])
        case .schoolName:
            return (.input, "e.g Harvard", Color.blue, [])
        case .educationLevel:
            return (.input, "e.g Masters", Color.blue, [])
        case .specificFieldOfStudy:
            return (.input, "e.g Computer Science", Color.blue, [])
        case .educationRecord:
            return (.twoBarButtons, "", Color.blue, [("START", Color.blue), ("END", Color.blue)])
        case .jobDescription:
            return (.description, "EXAMPLES", Color.grey, [])
        case .educationStatus:
             return (.threeBarButtons, "", Color.grey, [("IN SCHOOL", Color.grey), ("GRADUATED", Color.grey), ("NO HISTORY", Color.grey)])
        case .resumeName:
            return (.input, "e.g MyResume", Color.blue, [])
        }
    }
    
    //Do not put the same exam twice, you can change the order but that is all.
    static func examList() -> [Exam] {
        return [.menu, .name, /*.zipcode, .email, .gender ,*/ .employmentStatus, .educationStatus, .resumeName]
    }
    func kind() -> Kind {
        return getValues().kind
    }
    
    func next() -> Exam? {
        
        let nextIndex = Exam.examList().index(of: self)! + 1
        
        if Exam.examList().count > nextIndex {
            return Exam.examList()[nextIndex]
        }
        return nil
        
    }
    
    func hasBefore() -> Bool {
        if Exam.examList().indices.contains(self.hashValue-1) {
            return true
        }
        return false
    }
    
    func before() -> Exam? {
        return Exam.examList()[self.hashValue - 1]
    }
    
}

