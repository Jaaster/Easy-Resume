//
//  KeyboardSetup.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//
import UIKit

// MARK: Customizes the passed in textfield to a certain set of standards.
struct Keyboard {
    
    // MARK: Variables
    var textField: UITextField
    var examViewController: ExamViewController
    var currentExam: Exam
    
    // MARK: Dependency Injection of the current Inputable View Controller being presented and the textfield that users will accesable to users.
    init?(textField: UITextField, examViewController: ExamViewController) {
        self.examViewController = examViewController
        self.textField = textField
        
        //Mark: Checks to see if the Inputable View Controller is part of the Exam(An Exam is part of the app when a user is inputing data to customize or create their Resume)
        
        let modelManager = examViewController.modelManager
        // MARK: - Check to see if the currentModel is nil, if so return initializer
        guard let currentExam = modelManager?.currentModel?.exam else {
            return nil
        }
        self.currentExam = currentExam
    }
    
}

extension Keyboard {
    // Mark: Setup the textfield.
    func setup() {
        stopEditing()
        setAppropiateKeyboardType()
        startEditing()
    }
}

private extension Keyboard {
    
    // MARK: Brings up the keyboard
    func startEditing() {
        textField.becomeFirstResponder()
    }
    
    // MARK: Drops the keyboard
    func stopEditing() {
        textField.endEditing(true)
    }
}

private extension Keyboard {
    
    // MARK: Sets the easiest to use keyboard type for the user based off of what exam they are currently viewing.
    func setAppropiateKeyboardType() {
        
        // MARK: Not yet set type
        var type: UIKeyboardType!
        
        // MARK: This switch looks at the current exam that the user is being presented with and finds out what would be the best keyboard type for their task
        switch currentExam {
        case .email:
            type = UIKeyboardType.emailAddress
            
        case .zipcode:
            //MARK: Since the numberpad doesn't have a done button on the bottom right, we need to add one.
            setToolbar()
            type = UIKeyboardType.numberPad
            
        default:
            type = UIKeyboardType.default
        }
        // MARK: Updates the textfields keyboard type
        textField.keyboardType = type
    }
    
    // MARK: Sets a generated toolbar with a space button and a done buttom to the textField
    func setToolbar() {
        
        // MARK: Checks to see if the
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        if let informationVC = examViewController as? InformationVC {
            let button = UIBarButtonItem(barButtonSystemItem: .done, target: informationVC, action: #selector(informationVC.doneButtonPressed))
            toolBar.setItems([flexibleSpace, button], animated: false)
        }
        
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
    }
}

