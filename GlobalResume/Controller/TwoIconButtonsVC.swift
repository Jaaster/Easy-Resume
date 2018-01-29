//
//  TwoIconButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class TwoIconButtonsVC: UIViewController, LoadableVC {

    @IBOutlet weak var loadingView: FadeView!
    @IBOutlet weak var firstCircleButton: CircleButton!
    @IBOutlet weak var secondCircleButton: CircleButton!
    
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    
    @IBOutlet weak var firstIconImageView: UIImageView!
    @IBOutlet weak var secondIconImageView: UIImageView!
    var loadingViewColor: UIColor!

    var currentExam: Exam!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        updateData()
    }

    
    
    func updateData() {
        
        let values = currentExam.getValues()
        
        let buttons = values.buttons
        let color = buttons[0].color.getUIColor()
        let color2 = buttons[1].color.getUIColor()
        
        firstTitleLabel.text = buttons[0].name
        firstTitleLabel.textColor = color
        secondTitleLabel.textColor = color2
        secondTitleLabel.text = buttons[1].name
        
        firstIconImageView.image = UIImage(named: values.buttons[0].name)
        secondIconImageView.image = UIImage(named:values.buttons[1].name)
        
        firstCircleButton.round()
        secondCircleButton.round()
        firstCircleButton.backgroundColor = color
        secondCircleButton.backgroundColor = color2
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let text: String
        if sender.tag == 0 {
            text = firstTitleLabel.text!
        } else {
            text = secondTitleLabel.text!
        }
        handleTransportation(data: text)
    }
    
}
