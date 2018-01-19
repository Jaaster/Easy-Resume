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
    
    private var _isTriggered: Bool
    private var _examBeforeTrigger: Exam
    private var _trigger: Trigger
    
    
    
    init() {
        _isTriggered = false
        //Default values, mean nothing
        _examBeforeTrigger = Exam.email
        _trigger = Trigger.employed
    }
    
    var isTriggered: Bool {
        get {
            return _isTriggered
        }
        set{
            _isTriggered = newValue
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
    
    var trigger: Trigger {
        get {
            return _trigger
        }
        set {
            _trigger = newValue
        }
    }
    
}
