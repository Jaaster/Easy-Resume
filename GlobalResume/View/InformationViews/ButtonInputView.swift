//
//  ButtonInputView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class ButtonInputView: UIView {
    var buttons: [UIButton] = []
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.crayon.withSize(30)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ButtonInputView {
    func addButton() {
        buttons.append(createButton())
    }
    
    func setupViews() {
        removeSubviews()
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
      
        if !buttons.isEmpty {
            addButtonsToViewWithConstraints()
        }
    }
}

private extension ButtonInputView {
    
    func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.leadingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        button.titleLabel?.font = UIFont.crayon.withSize(25)
        button.titleLabel?.isUserInteractionEnabled = false 
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func addButtonsToViewWithConstraints() {
        
        var lastView: UIView = titleLabel
        for button in buttons {
            superview?.addSubview(button)
            button.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 25).isActive = true
            button.leadingAnchor.constraint(equalTo: lastView.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: lastView.trailingAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: 35).isActive = true
            lastView = button
        }
    }
}
