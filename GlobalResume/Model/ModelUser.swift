//
//  ModelUser.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/14/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation
class ModelUser {
    private var name: String
    private var email: String
    private var password: String
    private var resumes: [ResumeData]?
    
    init(name: String, email: String, password: String, resumes: [ResumeData]? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.resumes = resumes
    }
}
