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
    func fade(alpha: CGFloat, newTime: Double, completion: @escaping ()->())
    func fade(alpha: CGFloat, newTime: Double)
    
    func fadeSubviews(alpha: CGFloat, completion: @escaping ()->())
    func fadeSubviews(alpha: CGFloat)
}

extension UIView: Fadeable {
  
    
    
    var time: Double {
        get {
            return 1.0
        }
    }
    
    func fade(alpha: CGFloat, newTime: Double, completion: @escaping () -> ()) {
        UIView.animate(withDuration: newTime, animations: {
            self.alpha = alpha
        }, completion: {
            _ in
            completion()
        })
    }
    
    
    func fade(alpha: CGFloat, newTime: Double) {
        fade(alpha: alpha, newTime: newTime, completion: { })
    }
    
    
    func fadeSubviews(alpha: CGFloat) {
        fadeSubviews(alpha: alpha, completion: { })
    }
    
    func fade(alpha: CGFloat) {
        fade(alpha: alpha, completion: { })
    }
    
    func fadeSubviews(alpha: CGFloat, completion: @escaping () -> ()) {
        for subview in subviews {
//            if !subview.isHidden {
                subview.fade(alpha: alpha)
//            }
        }
        defer {
            completion()
        }
    }
   
    func fade(alpha: CGFloat, completion: @escaping ()->()) {
        UIView.animate(withDuration: time, delay: 0, options: [.allowUserInteraction], animations: {
             self.alpha = alpha
        }) { (_) in
              completion()
        }
    }
}


