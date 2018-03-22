//
//  ResumeData.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/14/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation
// This model is not used by a view, it simply stores this data and is mainly used by FirebaseHandler
class ResumeData {
    var uid = ""
    var currentEmployment: EmploymentModel?
    var currentEducation: EducationModel?
}
