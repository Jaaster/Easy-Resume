//
//  TwoIconButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class TwoIconButtonsVC: UIViewController, ExamViewController {
    
    var modelManager: ModelManager<ModelExam>!
    var dataHandler: ResumeDataHandler!

    @IBOutlet weak var firstCircleButton: CustomButton!
    @IBOutlet weak var secondCircleButton: CustomButton!
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var firstIconImageView: UIImageView!
    @IBOutlet weak var secondIconImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViewsWithNewData() {
        guard let currentModelExam = modelManager.currentModel else { return }

        guard let buttons = currentModelExam.buttonModels else { return }
        
        let color = buttons[0].color
        let color2 = buttons[1].color
        
        firstTitleLabel.text = buttons[0].title
        firstTitleLabel.textColor = color
        secondTitleLabel.textColor = color2
        secondTitleLabel.text = buttons[1].title
        
        firstIconImageView.image = UIImage(named: buttons[0].title)
        secondIconImageView.image = UIImage(named: buttons[1].title)
        
        firstCircleButton.round()
        secondCircleButton.round()
        firstCircleButton.backgroundColor = color
        secondCircleButton.backgroundColor = color2
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        var text: String?
        if sender.tag == 0 {
            if let title = firstTitleLabel.text {
                text = title
            }
        } else {
            if let title = secondTitleLabel.text {
                text = title
            }
        }
       
        let transitionHandler = TransitionHandler(currentExamViewController: self)
        transitionHandler.decideCourse(data: text)
    }
}
