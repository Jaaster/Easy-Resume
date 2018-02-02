//
//  UICircleButton.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/17/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class CustomButton: UIButton, Roundable {}

extension CustomButton {
    
    func transportationStyle(title: String, bgcolor: UIColor) {
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        setTitleColor(.white, for: .normal)
        backgroundColor = bgcolor
        translatesAutoresizingMaskIntoConstraints = false
        round(scale: 8)
    }
}
