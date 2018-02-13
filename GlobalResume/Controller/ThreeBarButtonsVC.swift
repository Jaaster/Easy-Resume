//
//  UnlimitedButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class ThreeBarButtonsVC: UIViewController, ExamViewController {
    
    var modelManager: ModelManager<ModelExam>!
    var dataHandler: ResumeDataHandler!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViewsWithNewData() {
        circleView.round()

        guard let currentModelExam = modelManager.currentModel else { return }

        let buttons = currentModelExam.buttonModels
        let color = currentModelExam.color
    
        iconImageView.image = UIImage(named: currentModelExam.title)
        titleLabel.text = currentModelExam.title
        
        titleLabel.textColor = color
        circleView.backgroundColor = color
        
        let buttonArray = [firstButton, secondButton, thirdButton]
        
        for i in 0..<buttonArray.count {
            let button = buttonArray[i]
            button?.setTitle(buttons?[i].title, for: .normal)
            button?.backgroundColor = buttons?[i].color
            button?.titleLabel?.textAlignment = NSTextAlignment.center
            
        }
    }
    
    @IBAction func buttonsPressed(_ sender: UIButton) {
        if let data = sender.titleLabel?.text {
            
            let transitionHandler = TransitionHandler(currentExamViewController: self)
            transitionHandler.decideCourse(data: data)
        }
    }
}
