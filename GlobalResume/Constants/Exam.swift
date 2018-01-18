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
            return (.twoButtons,"", Color.clear, [("JuNKY", Color.pink), ("SEXY", Color.blue)])
        case .number:
            return (.input,"e.g 1 (931) 390 3949", Color.grey, [])
        case .zipcode:
            return (.input,"", Color.grey, [])
        case .employmentStatus:
            return (.unlimitedButtons, "EMPLOYMENT STATUS", Color.blue, [("EMPLOYED", Color.grey), ("UNEMPLOYED", Color.pink), ("NO HISTORY", Color.blue)])
        case .menu:
            return (.main, "", Color.clear, [])
        }
    }
    
    static func allValues() -> [Exam] {
        return [.menu, .employmentStatus, .name, .email]
    }
    
    func kind() -> Kind {
        return getValues().kind
    }
    
    private func hasNext() -> Bool {
        if Exam.allValues().count > self.hashValue + 1 {
            return true
        }
        return false
    }
    
    func next() -> Exam? {
        var exam: Exam?
        if hasNext() {
            exam = Exam.allValues()[self.hashValue + 1]
            return exam
        } else {
            return exam
        }
    }
    
    func hasBefore() -> Bool {
        if Exam.allValues().indices.contains(self.hashValue-1) {
            return true
        }
        return false
    }
    
    func before() -> Exam? {
        return Exam.allValues()[self.hashValue - 1]
    }
    
}
