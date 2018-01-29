//
//  Roundable.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/17/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

protocol Roundable {}

extension Roundable where Self: UIView {
    
    func round() {
        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = true
    }
    
    func round(scale: CGFloat) {
        layer.cornerRadius = scale
        clipsToBounds = true
    }
}
