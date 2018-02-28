//
//  InputView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class KeyboardInputView: UIView {

    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.font = UIFont.crayon.withSize(20)
        textField.adjustsFontSizeToFitWidth = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        addSubview(inputTextField)
        inputTextField.allEdgesConstraints(parentView: self, spacing: 0)
    }
    
}
