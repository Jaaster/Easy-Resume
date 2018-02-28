//
//  KeyboardSetup.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//
import UIKit

// MARK: Customizes the passed in textfield to a certain set of standards.
struct KeyboardSetup {
    
    private var textField: UITextField?
    private var textView: UITextView?
    private var currentExam: Exam
    private var viewController: UIViewController

    init?(textField: UITextField?, textView: UITextView?, viewController: UIViewController) {
        guard let navigationController = viewController.navigationController as? CustomNavigationController else { return nil }
        guard let currentExam = navigationController.modelManager.currentModel?.exam else { return nil}
        
        self.currentExam = currentExam
        self.textField = textField
        self.textView = textView
        self.viewController = viewController
    }
}

extension KeyboardSetup {
    // Mark: Setup the textfield.
    func setup() {
        stopEditing()
        setAppropiateKeyboardType()
        startEditing()
    }
}

private extension KeyboardSetup {
    
    // MARK: Brings up the keyboard
    func startEditing() {
        if let textField = textField {
            textField.becomeFirstResponder()
        }
    }
    
    // MARK: Drops the keyboard
    func stopEditing() {
        if let textField = textField {
            textField.endEditing(true)
        }
        
        if let textView = textView {
            textView.endEditing(true)
        }
    }
}

private extension KeyboardSetup {
    
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
        case .jobDescription, .profileDescription, .educationDescription:
            setToolbar()
            fallthrough
        default:
            type = UIKeyboardType.default
        }
        // MARK: Updates the textfields keyboard type
        if let textField = textField {
            textField.keyboardType = type
        } else if let textView = textView {
            textView.keyboardType = type
        }
    }
    
    // MARK: Sets a generated toolbar with a space button and a done buttom to the textField
    func setToolbar() {
        
        // MARK: Checks to see if the
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        if let informationVC = viewController as? InformationVC {
            let button = UIBarButtonItem(barButtonSystemItem: .done, target: informationVC, action: #selector(informationVC.doneButtonPressed))
            toolBar.setItems([flexibleSpace, button], animated: false)
        } else if let descriptionVC = viewController as? DescriptionVC {
            let button = UIBarButtonItem(barButtonSystemItem: .done, target: descriptionVC, action: #selector(descriptionVC.doneButtonPressed))
            toolBar.setItems([flexibleSpace, button], animated: false)
        }
        
        toolBar.sizeToFit()
        if let textField = textField {
            textField.inputAccessoryView = toolBar
        } else if let textView = textView {
            textView.inputAccessoryView = toolBar
        }
    }
}

