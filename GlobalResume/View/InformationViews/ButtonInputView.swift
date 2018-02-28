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
        addButtonsToViewWithConstraints()
    }
}

private extension ButtonInputView {
    
    func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.leadingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        button.titleLabel?.font = UIFont.crayon.withSize(20)
        button.titleLabel?.isUserInteractionEnabled = false 
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func addButtonsToViewWithConstraints() {
        guard let firstButton = buttons.first else { return }
        addSubview(firstButton)
        firstButton.anchor(topAnchor, left: leadingAnchor, bottom: nil, right: trailingAnchor, topConstant: 60, leftConstant: 10, bottomConsant: 0, rightConstant: -10, widthConstant: 0, heightConstant: 35)
        
        
        var lastView: UIView = firstButton
        for button in buttons.dropFirst() {
            superview?.addSubview(button)
            button.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 25).isActive = true
            button.leadingAnchor.constraint(equalTo: lastView.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: lastView.trailingAnchor).isActive = true
            button.heightAnchor.constraint(equalToConstant: 35).isActive = true
            lastView = button
        }
    }
}
