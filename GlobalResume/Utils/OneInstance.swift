//
//  OneInstance.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/19/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

class OneInstance {
    
    static let shared = OneInstance()
    
    private var _examBeforeTrigger: Exam
    var trigger: Trigger?
    private var _exampleJobList: Set<String>
    
    
    init() {
        //Default values, mean nothing
        _examBeforeTrigger = Exam.email
        _exampleJobList = Set<String>()
    }
    
    var exampleJobList: Set<String> {
        get {
            return _exampleJobList
        }
        set {
            _exampleJobList = newValue
        }
    }
    
    var examBeforeTrigger: Exam {
        get {
            return _examBeforeTrigger
        }
        set {
            _examBeforeTrigger = newValue
        }
    }
    
}
