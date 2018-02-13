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
