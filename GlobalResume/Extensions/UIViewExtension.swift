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
        bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: spacing)
    }
}

