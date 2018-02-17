//
//  InputView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class KeyboardInputView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.crayon.withSize(30)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont.crayon.withSize(25)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension KeyboardInputView {
    
    func setupViews() {
        
        addSubview(titleLabel)
        addSubview(inputTextField)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        inputTextField.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 60).isActive = true
        inputTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        inputTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        
        
    }
}
