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
    case profileDescription = "PROFILE DESCRIPTION"
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
    case educationDescription = "EDUCATION DESCRIPTION"
    
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
            return (.input, "e.g Jerry Springer", Color.blue, [])
        case .gender:
            return (.twoButtons,"", Color.clear, [("MALE", Color.blue), ("FEMALE", Color.pink)])
        case .email:
            return (.input, "example@gmail.com", Color.blue, [])
        case .number:
            return (.input,"e.g 1 (931) 390 3949", Color.blue, [])
        case .zipcode:
            return (.input, "e.g 37052", Color.blue, [])
        case .employmentStatus:
            return (.threeBarButtons, "", Color.blue, [("EMPLOYED", Color.blue), ("UNEMPLOYED", Color.blue), ("NO HISTORY", Color.blue)])
        case .menu:
            return (.main, "", Color.clear, [])
        case .companyName:
            return (.input, "e.g Apple", Color.blue, [])
        case .jobTitle:
            return (.input, "e.g Manager", Color.blue, [])
        case .employmentRecord:
            return (.twoBarButtons, "", Color.blue, [("START", Color.blue), ("END", Color.blue)])
        case .schoolName:
            return (.input, "e.g Harvard", Color.blue, [])
        case .educationLevel:
            return (.input, "e.g Masters", Color.blue, [])
        case .specificFieldOfStudy:
            return (.input, "e.g Computer Science", Color.blue, [])
        case .educationRecord:
            return (.twoBarButtons, "", Color.blue, [("START", Color.blue), ("END", Color.blue)])
        case .jobDescription:
            return (.description, "EXAMPLES", Color.blue, [])
        case .educationStatus:
             return (.threeBarButtons, "", Color.blue, [("IN SCHOOL", Color.blue), ("GRADUATED", Color.blue), ("NO HISTORY", Color.blue)])
        case .resumeName:
            return (.input, "e.g MyResume", Color.blue, [])
        case .educationDescription:
            return (.description, "EXAMPLES", Color.blue, [])
        case .profileDescription:
            return (.description, "EXAMPLES", Color.blue, [])

        }
    }
    
    //Do not put the same exam twice, you can change the order but that is all.
    static func examList() -> [Exam] {
        return [.menu, .name, .zipcode, .email, .gender , .employmentStatus, .educationStatus, .profileDescription, .resumeName]
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

