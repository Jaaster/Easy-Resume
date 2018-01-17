//
//  ResumeData.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class ResumeData {
    var name: String!
    var gender: Gender!
    var email: String!
    var phoneNumber: String!
    var zipCode: String!
    
    func saveData(exam: Exam, data: String) {
        
        switch exam {
        case .name:
            name = data
        case .gender:
           gender = Gender(rawValue: data)
        case .email:
            email = data
        case .number:
            phoneNumber = data
        case .zipcode:
            zipCode = data
        }
    }
}




