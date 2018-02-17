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
        let containerView = transitionContext.containerView
        
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        toViewController.transitioningDelegate = fromViewController.transitioningDelegate
        toViewController.modalPresentationStyle = .custom
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        containerView.addSubview(fromView)
        
        
        let transform = CGAffineTransform(translationX: 0.0, y: UIScreen.main.bounds.height)
        let loadingView = UIView(frame: UIScreen.main.bounds)
        
        guard let fromExamViewController = fromViewController as? ExamViewController else { return }
        guard let color = fromExamViewController.modelManager.currentModel?.color else { return }
        
        loadingView.backgroundColor = color
        loadingView.transform = transform
        containerView.addSubview(loadingView)
        
        UIView.animate(withDuration: 1.0, animations: {
            loadingView.transform = CGAffineTransform.identity
        }, completion: { _ in
            
            loadingView.removeFromSuperview()
            containerView.addSubview(toView)
            containerView.addSubview(loadingView)
            
            UIView.animate(withDuration: 1.0, animations: {
                loadingView.transform = transform
            }, completion: { _ in
                transitionContext.completeTransition(true )
            })
        })
        
    }
}

