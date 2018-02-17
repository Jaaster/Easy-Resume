//
//  TransitionHandler.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/11/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
struct TransitionService {
    
    // MARK: Present new View Controller
    func present(nextViewController: UIViewController, from currentViewController: UIViewController) {
        
        guard let nextExamViewController = nextViewController as? ExamViewController else {
            fatalError("Attempted to present view controller from Transportation that does not inheret the ExamViewController Protocol") }
        
        currentViewController.navigationController?.present(nextViewController, animated: true, completion: {
            nextExamViewController.updateViewsWithNewData()
        })
    }
    
    // MARK: - Dismisses one View Controller. This View Controller is one level higher in View Controller Hierachy than the View Controller desired to dismiss to
    func dismiss(to viewController: UIViewController, animated: Bool, completion: (()->())? = nil) {
            // MARK: - Dismiss the viewcontroller we to see, therefor it will dismiss all of the View Controllers higher than itself
            viewController.dismiss(animated: animated, completion: completion)
    }
    
    // MARK: Dismiss the view that is one slot from the Root View Controller
    func dismissToRootViewController() {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            dismiss(to: rootVC, animated: true, completion: nil)
        }
        return
    }
}
