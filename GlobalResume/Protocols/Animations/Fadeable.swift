//
//  Fadeable.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/17/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

protocol Fadeable: Animatable {
    func fade(alpha: CGFloat)
}

extension Fadeable where Self: UIView {
    func fade(alpha: CGFloat) {
        UIView.animate(withDuration: time, animations: {
            self.alpha = alpha
        })
    }
}

