//
//  InputVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class InputVC: UIViewController, LoadableVC {
    
    var presenting: UIViewController!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var circleView: CircleView!
    var currentExam: Exam!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        handlePreviousController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    
    func generateKeyboardStyle() -> UIKeyboardType {
        switch currentExam! {
        case .email:
            return UIKeyboardType.emailAddress
        case .zipcode:
            addToolBarToKeyboard()
            return UIKeyboardType.numberPad
        default:
            return UIKeyboardType.default
        }
    }
    
    func updateData() {
        circleView.round()
        textField.keyboardType = generateKeyboardStyle()

        let values = currentExam.getValues()
        let color = values.color
        
        titleLabel.text = currentExam.rawValue
        textField.placeholder = values.example
        textField.text = ""
        iconImageView.image = UIImage(named: currentExam.rawValue)
        
        barView.backgroundColor = color
        circleView.backgroundColor = color
        titleLabel.textColor = color
    }
    
}

extension InputVC: UITextFieldDelegate {
    
    @objc func doneButtonPressed() {
        if let data = textField.text {
            textField.endEditing(true)
            handleTransportation(data: data)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if !text.isEmpty{
                textField.endEditing(true)
                handleTransportation(data: text)
                return true
            }
        }
        return false
    }
    
    func addToolBarToKeyboard() {
        let toolBar = UIToolbar()
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.sizeToFit()
        toolBar.setItems([flexibleSpace, button], animated: false)
        
        textField.inputAccessoryView = toolBar
    }
}
