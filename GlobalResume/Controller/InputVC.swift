//
//  InputVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class InputVC: UIViewController, ExamViewController {
    
    var modelManager: ModelManager<ModelExam>!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var circleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
    func updateViewsWithNewData() {
        circleView.round()
        
        guard let currentModelExam = modelManager.currentModel else { return }
        
        let color = currentModelExam.color
        let title = currentModelExam.title
        titleLabel.text = title
        textField.placeholder = title
        iconImageView.image = UIImage(named: title)
        textField.text = ""
        
        barView.backgroundColor = color
        circleView.backgroundColor = color
        titleLabel.textColor = color
    }
}

extension InputVC: UITextFieldDelegate {
   
}

extension InputVC: Inputable {
    @objc func doneButtonPressed() {
        guard let data = textField.text else { return }
        let transitionHandler = TransitionHandler(currentExamViewController: self)
        transitionHandler.decideCourse(data: data)
    }
}
