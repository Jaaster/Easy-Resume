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
    case resumeName = "RESUME NAME"
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

    case examEnded = "EXAM ENDED"
    
    func configureToVariableName() -> String {
        var string = self.rawValue
        string = string.replacingOccurrences(of: " ", with: "_")
        string = string.lowercased()
        return string
    }
    
    
}
