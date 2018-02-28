//
//  CustomNavigationController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    var currentResume: ResumeModel?
    let transition = CustomTransition()
    var modelManager = ModelManager<ExamModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitioningDelegate = self
        navigationBar.isHidden = true 
    }
}

extension CustomNavigationController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
