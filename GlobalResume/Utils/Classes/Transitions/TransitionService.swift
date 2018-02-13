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
        
        // MARK: Presents the Next View Controller that was passed in the parameters
        currentViewController.present(nextViewController, animated: true, completion: {
            // MARK: Updates the View of the presented controller with ModelExam data stored in the currentModelExam variable of ModelManager
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

private extension TransitionService {
    
    // MARK: - Returns the Top View Controller ;)
    func topViewController() -> UIViewController? {
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            if let topViewController = rootVC.presentedViewController {
                // MARK: - Loops until it finds that the current View Controller in the loop doesn't have a Presenting View Controller
                var nextTopViewController = topViewController
                while nextTopViewController.presentedViewController != nil {
                    if let presentedViewController = nextTopViewController.presentedViewController {
                        // MARK: - Set the topViewController to the latest presented view controller
                        nextTopViewController = presentedViewController
                    } else {
                        break
                    }
                }
            }
            return rootVC
        }
        return nil
    }
}
