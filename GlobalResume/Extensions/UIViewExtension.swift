//
//  UIViewControllerExtension.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
extension UIView {
    func removeSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
}

extension UIView {
    func allEdgesConstraints(parentView: UIView, spacing: CGFloat) {
        topAnchor.constraint(equalTo: parentView.topAnchor, constant: spacing).isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: spacing).isActive = true
        trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -spacing).isActive = true
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -spacing).isActive = true
    }
    
    func anchor(_ anchor: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, topConstant: CGFloat, leftConstant: CGFloat, bottomConsant: CGFloat, rightConstant: CGFloat, widthConstant: CGFloat, heightConstant: CGFloat) {
        if let anchor = anchor {
            topAnchor.constraint(equalTo: anchor, constant: topConstant).isActive = true
        }
        
        if let left = left {
            leadingAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        
        if let right = right {
            trailingAnchor.constraint(equalTo: right, constant: rightConstant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: bottomConsant).isActive = true
        }
        
        if widthConstant > 0 {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
        
        if heightConstant > 0 {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }

    }
}

extension UIView {
    
    func shake(rotationDegrees: CGFloat, duration: Double, count: Int, completion: @escaping () -> ()) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = self.transform.rotated(by: rotationDegrees)
        }, completion: { _ in
            
            UIView.animate(withDuration: duration, animations: {
                self.transform = CGAffineTransform.identity
            }, completion: { _ in
                if count < 1 {
                    completion()
                    return
                }
                
                UIView.animate(withDuration: duration, animations: {
                    self.transform = self.transform.rotated(by: -rotationDegrees)
                }, completion: { _ in
                    UIView.animate(withDuration: duration, animations: {
                        self.transform = CGAffineTransform.identity
                    }, completion: { _ in
                        self.shake(rotationDegrees: rotationDegrees, duration: duration, count: count-1, completion: completion)
                        
                    })
                    
                })
                
            })
        })
    }
    
    func expandAnimation(duration: TimeInterval, scaleX: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: scaleX, y: y)
        }, completion: { _ in
            UIView.animate(withDuration: duration, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
}
