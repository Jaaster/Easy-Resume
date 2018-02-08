//
//  Exam.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

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
    
    func getValues() -> (kind: Kind, example: String, color: UIColor, buttons: [(name: String, color: UIColor)]){
        let color = UIColor.self
        switch self {
        case .name:
            return (.input, "e.g Jerry Springer", color.myPink, [])
        case .gender:
            return (.twoButtons,"", color.clear, [("MALE", color.myBlue), ("FEMALE", color.myPink)])
        case .email:
            return (.input, "example@gmail.com", color.myBlue, [])
        case .number:
            return (.input,"e.g 1 (931) 390 3949", color.myBlue, [])
        case .zipcode:
            return (.input, "e.g 37052", color.myBlue, [])
        case .employmentStatus:
            return (.threeBarButtons, "", color.myBlue, [("EMPLOYED", color.myBlue), ("UNEMPLOYED", color.myBlue), ("NO HISTORY", color.myBlue)])
        case .menu:
            return (.main, "", color.clear, [])
        case .companyName:
            return (.input, "e.g Apple", color.myBlue, [])
        case .jobTitle:
            return (.input, "e.g Manager", color.myBlue, [])
        case .employmentRecord:
            return (.twoBarButtons, "", color.myBlue, [("START", color.myBlue), ("END", color.myBlue)])
        case .schoolName:
            return (.input, "e.g Harvard", color.myBlue, [])
        case .educationLevel:
            return (.input, "e.g Masters", color.myBlue, [])
        case .specificFieldOfStudy:
            return (.input, "e.g Computer Science", color.myBlue, [])
        case .educationRecord:
            return (.twoBarButtons, "", color.myBlue, [("START", color.myBlue), ("END", color.myBlue)])
        case .jobDescription:
            return (.description, "EXAMPLES", color.myBlue, [])
        case .educationStatus:
             return (.threeBarButtons, "", color.myBlue, [("IN SCHOOL", color.myBlue), ("GRADUATED", color.myBlue), ("NO HISTORY", color.myBlue)])
        case .resumeName:
            return (.input, "e.g MyResume", color.myBlue, [])
        case .educationDescription:
            return (.description, "EXAMPLES", color.myBlue, [])
        case .profileDescription:
            return (.description, "EXAMPLES", color.myBlue, [])

        }
    }
    
    //Do not put the same exam twice, you can change the order but resumeName must always be the last element.
    private func examList() -> [Exam] {
        return [.menu, .name, .zipcode, .email, .gender , .employmentStatus, .educationStatus, .profileDescription, .resumeName]
    }
    
    func kind() -> Kind {
        return getValues().kind
    }
    
    func next() -> Exam? {
        
        let nextIndex = examList().index(of: self)! + 1
        
        if examList().count > nextIndex {
            return examList()[nextIndex]
        }
        return nil
    }
}

