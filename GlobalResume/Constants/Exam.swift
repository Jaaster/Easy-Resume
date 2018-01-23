//
//  Exam.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

enum Exam: String {
    case menu = "MENU"
    case name = "NAME"
    case gender = "GENDER"
    case email = "EMAIL"
    case number = "PHONE NUMBER"
    case zipcode = "ZIP CODE"
    case employmentStatus = "EMPLOYMENT STATUS"
    case companyName = "COMPANY NAME"
    case jobTitle = "JOB TITLE"
    case employmentRecord = "EMPLOYMENT RECORD"
    case pursuingEducation = "PURSUING EDUCATION"
    case schoolName = "SCHOOL NAME"
    case educationLevel = "EDUCATION LEVEL"
    case specificFieldOfStudy = "SPECIFIC FIELD OF STUDY"
    case completionDate = "COMPLETION DATE"
    
    enum Kind:String {
        case main = "MAIN"
        case input = "INPUT"
        case twoButtons = "TWOBUTTONS"
        case unlimitedButtons = "UNLIMITEDBUTTONS"
        
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
            return (.unlimitedButtons, "", Color.grey, [("EMPLOYED", Color.grey), ("UNEMPLOYED", Color.grey), ("NO HISTORY", Color.grey)])
        case .menu:
            return (.main, "", Color.clear, [])
        case .companyName:
            return (.input, "e.g Apple", Color.grey, [])
        case .jobTitle:
            return (.input, "e.g Manager", Color.grey, [])
        case .employmentRecord:
            return (.twoButtons, "", Color.grey, [("START", Color.grey), ("END", Color.grey)])
        case .pursuingEducation:
            return (.twoButtons, "", Color.blue, [("YES", Color.blue), ("NO", Color.blue)])
        case .schoolName:
            return (.input, "e.g Harvard", Color.blue, [])
        case .educationLevel:
            return (.input, "e.g Masters", Color.blue, [])
        case .specificFieldOfStudy:
            return (.input, "e.g Computer Science", Color.blue, [])
        case .completionDate:
            return (.twoButtons, "", Color.blue, [("START", Color.blue), ("END", Color.blue)])

        }
    }
    
    //Do not put the same exam twice, you can change the order but that is all.
    static func examList() -> [Exam] {
        return [.menu, .employmentStatus, .pursuingEducation, .schoolName, .educationLevel, .specificFieldOfStudy, .completionDate]
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
