//
//  FIRCollectionReference.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/25/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

enum FIRCollectionReferenceParent: String {
    case examples = "Examples"
    
    enum Child: String {
        case jobs = "Jobs"
        case education = "EducationDescription"
        case profile = "ProfileDescription"
    }
}
