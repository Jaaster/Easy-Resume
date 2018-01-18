//
//  UpdateViews.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/17/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class UpdateViews {
    
     func update(destinationVC: LoadableVC) {
        
        if let vc = destinationVC as? MainVC {
            update(vc: vc)
        } else if let vc = destinationVC as? InputVC {
            update(vc: vc)
        } else if let vc = destinationVC as? TwoIconButtonsVC {
            update(vc: vc)
        } else if let vc = destinationVC as? UnlimitedButtonsVC {
            update(vc: vc)
        }
    }
    
    
    private func update(vc: MainVC) {
        vc.firstCircleView.round()
        vc.secondCircleView.round()
    }
    
    
    private func update(vc: UnlimitedButtonsVC) {
        
        let values = vc.currentExam.getValues()
        let buttons = values.buttons
        
        vc.iconImageView.image = UIImage(named: vc.currentExam.rawValue)
        vc.titleLabel.text = vc.currentExam.rawValue
        
        vc.circleView.round()
        
        vc.circleView.backgroundColor = values.color.getUIColor()
        
        vc.firstButton.titleLabel?.text = buttons[0].name
        vc.secondButton.titleLabel?.text = buttons[1].name
        vc.thirdButton.titleLabel?.text = buttons[2].name
        
        
        vc.firstButton.backgroundColor = buttons[0].color.getUIColor()
        vc.secondButton.backgroundColor = buttons[1].color.getUIColor()
        vc.thirdButton.backgroundColor = buttons[2].color.getUIColor()
        
        
    }
    
    
    private func update(vc: TwoIconButtonsVC) {
        
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
        
        vc.firstCircleButton.round()
        vc.secondCircleButton.round()
        vc.firstCircleButton.backgroundColor = color
        vc.secondCircleButton.backgroundColor = color2
        
    }
    
    private func update(vc: InputVC) {
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
