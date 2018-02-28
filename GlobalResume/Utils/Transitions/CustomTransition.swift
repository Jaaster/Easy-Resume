//
//  CustomTransition.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class CustomTransition: NSObject {}

extension CustomTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}

