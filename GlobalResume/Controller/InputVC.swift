//
//  InputVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class InputVC: UIViewController, UITextFieldDelegate, LoadableVC {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var circleView: UICircleView!
    @IBOutlet weak var loadingView: UILoadView!
    
    var loadingViewColor: UIColor!
    var currentExam: Exam!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        loadingView.backgroundColor = loadingViewColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
      
        loadingView.backgroundColor = currentExam.getValues().color.getUIColor()
        
        if let data = textField.text {
            handleTransportation(dataType: currentExam, data: data)
            return true
        }
        return false
    }
    
}


