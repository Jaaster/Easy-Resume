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
    func fade(alpha: CGFloat, completion: @escaping ()->())
}

extension Fadeable where Self: UIView {
    func fade(alpha: CGFloat) {
        UIView.animate(withDuration: time, animations: {
            self.alpha = alpha
        })
    }
    
    func fade(alpha: CGFloat, completion: @escaping ()->()) {
        UIView.animate(withDuration: time, animations: {
            self.alpha = alpha
        }, completion: {
            _ in
            completion()
        })
    }
}

