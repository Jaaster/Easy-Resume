//
//  Exam.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

enum Exam: String {
    
    case name = "NAME"
    case gender = "GENDER"
    case email = "EMAIL"
    case number = "NUMBER"
    case zipcode = "ZIPCODE"
    
    
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
            return (kind: .input, "e.g Jerry Springer", Color.blue, [])
        case .gender:
            return (kind: .twoButtons,"", Color.green, [("MALE", Color.blue), ("FEMALE", Color.pink)])
        case .email:
            return (kind: .input,"e.g stevejobs@gmail.com", Color.blue, [])
        case .number:
            return (kind: .input,"e.g 1 (931) 390 3949", Color.grey, [])
        case .zipcode:
            return (kind: .input,"", Color.grey, [])
        }
    }
    
    func allValues() -> [Exam] {
        return [.name, .gender, .email, .number, .zipcode]
    }
    
    func kind() -> Kind {
        return getValues().kind
    }
    
    func hasNext() -> Bool {
        if allValues().indices.contains(self.hashValue + 1) {
            return true
        }
        return false
    }
    
    func next() -> Exam {
        return allValues()[self.hashValue + 1]
    }
    
    func hasBefore() -> Bool {
        if allValues().indices.contains(self.hashValue-1) {
            return true
        }
        return false
    }
    
    func before() -> Exam? {
        return allValues()[self.hashValue - 1]
    }
    
}
