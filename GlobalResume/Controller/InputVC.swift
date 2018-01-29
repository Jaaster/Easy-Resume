//
//  InputVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class InputVC: UIViewController, LoadableVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var loadingView: FadeView!
    
    var loadingViewColor: UIColor!
    var currentExam: Exam!
    
    
    override func loadView() {
       super.loadView()
        updateData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }

    
    
    func updateData() {
        let values = currentExam.getValues()
        
        let color = values.color.getUIColor()
        
        circleView.round()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
                
        if let data = textField.text {
            handleTransportation(data: data)
            return true
        }
        return false
    }
}


