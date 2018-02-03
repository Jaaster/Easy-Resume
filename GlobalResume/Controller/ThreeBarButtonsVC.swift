//
//  UnlimitedButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class ThreeBarButtonsVC: UIViewController, LoadableVC {
   
    var currentExam: Exam!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var circleView: CircleView!
    
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   
    func updateData() {
        
        let values = currentExam.getValues()
        let buttons = values.buttons
        let color = values.color.getUIColor()
    
        iconImageView.image = UIImage(named: currentExam.rawValue)
        titleLabel.text = currentExam.rawValue
        
        titleLabel.textColor = color
        circleView.round()
        circleView.backgroundColor = color
        
        let buttonArray = [firstButton, secondButton, thirdButton]
        
        for i in 0..<buttonArray.count {
            let button = buttonArray[i]
            button?.setTitle(buttons[i].name, for: .normal)
            button?.backgroundColor = buttons[i].color.getUIColor()
            button?.titleLabel?.textAlignment = NSTextAlignment.center
            
        }
    }
    
    
    
    @IBAction func buttonsPressed(_ sender: UIButton) {
        handleTransportation(data: (sender.titleLabel?.text!)!)
    }
 
    
}
