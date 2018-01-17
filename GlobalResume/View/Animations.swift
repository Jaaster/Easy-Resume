//
//  Animations.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit


struct Animations {
    
    func fadeOut(view: UIView, seconds: Double) {
        UIView.animate(withDuration: seconds, animations: {
            view.alpha = 0.0
        })
    }
    
    func performSegue(vc: Loadable, withIdentifier: String, sender: Any?) {
        loadWithSegue(vc: vc, seconds: 0.7, withIdentifier: withIdentifier, sender: sender)
    }
    
    
    
    func loadWithSegue(vc: Loadable, seconds: Double, withIdentifier: String, sender: Any?) {
        if let viewController = vc as? UIViewController {
            
            viewController.view.addSubview(vc.loadingView)
            
                UIView.animate(withDuration: seconds, animations: {
            
                    vc.loadingView.transform = CGAffineTransform(scaleX: 5, y: 5)
            
            }, completion: { _ in
                viewController.performSegue(withIdentifier: withIdentifier, sender: sender)
        })
        
        }
    }
    
    func load(seconds: Double, vc: Loadable) {
        
        if let viewController = vc as? UIViewController {
            viewController.view.addSubview(vc.loadingView)
        }
        
        vc.loadingView.backgroundColor = vc.loadingViewColor
        UIView.animate(withDuration: seconds, animations: {
            vc.loadingView.transform = CGAffineTransform(scaleX: 5, y: 5)
        }, completion: { _ in
            self.update(vc: vc)
            self.unload(seconds: seconds, vc: vc)
        })
    }
    
    func unload(seconds: Double, vc: Loadable) {
        UIView.animate(withDuration: seconds, animations: {
            vc.loadingView.transform = CGAffineTransform.identity
        }, completion: { _ in
            if let viewController = vc as? UIViewController {
                viewController.view.willRemoveSubview(vc.loadingView)
                vc.defaultLoadingViewColor()
            }
        })
    }
    
     private func update(vc: Loadable) {
        if let vc = vc as? MainVC {
            //NO need to update
        } else if let vc = vc as? InputVC {
            update(vc: vc)
        } else if let vc = vc as? TwoIconButtonsVC {
            update(vc: vc)
        }
    }
    
     func update(vc: TwoIconButtonsVC) {
        
        let values = vc.currentExam.getValues()

        let buttons = values.buttons
        let color = buttons[0].color.getUIColor()
        let color2 = buttons[1].color.getUIColor()
        
        vc.firstTitleLabel.text = buttons[0].name
        vc.firstTitleLabel.textColor = color
        vc.secondTitleLabel.textColor = color2
        vc.secondTitleLabel.text = buttons[1].name
        
        vc.firstIconImageView.image = UIImage(named: values.buttons[0].name)
        vc.secondIconImageView.image = UIImage(named:values.buttons[1].name)
        
        vc.firstCircleView.round()
        vc.secondCircleView.round()
        vc.firstCircleView.backgroundColor = color
        vc.secondCircleView.backgroundColor = color2
        
    }
    
     func update(vc: InputVC) {
        let values = vc.currentExam.getValues()
        
        let color = values.color.getUIColor()

        vc.circleView.round()
        vc.titleLabel.text = vc.currentExam.rawValue
        vc.textField.text = values.example
        vc.iconImageView.image = UIImage(named: vc.currentExam.rawValue)
        
        vc.barView.backgroundColor = color
        vc.circleView.backgroundColor = color
        vc.titleLabel.textColor = color
    }
    

}

