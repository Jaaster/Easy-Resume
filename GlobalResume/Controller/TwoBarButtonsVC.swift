//
//  TwoBarButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/23/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class TwoBarButtonsVC: UIViewController, ExamViewController {
    
    var modelManager: ModelManager<ModelExam>!
    var dataHandler: ResumeDataHandler!

    private var startDate: String?
    private var endDate: String?
    
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!

    var dateHasBeenSet = (start: false, end: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    func updateViewsWithNewData() {
        
        guard let currentModelExam = modelManager.currentModel else { return }
        let color = currentModelExam.color

        iconImageView.image = UIImage(named: currentModelExam.title)
        titleLabel.text = currentModelExam.title
        titleLabel.textColor = color
        
        circleView.backgroundColor = color
        circleView.round()

        startPicker.backgroundColor = color
        endPicker.backgroundColor = color
       
        nextButton.backgroundColor = color
        nextButton.isHidden = true
        
        setupButtons()
    }
    
    private func setupButtons() {
        let buttonArray = [firstButton, secondButton]
        
        guard let currentExamModel = modelManager.currentModel else { return }
        
        let buttonDataFromExam = currentExamModel.buttonModels
        
        for i in 0..<buttonArray.count {
            let button = buttonArray[i]
            button?.setTitle(buttonDataFromExam?[i].title, for: .normal)
            button?.backgroundColor = buttonDataFromExam?[i].color
            button?.titleLabel?.textAlignment = NSTextAlignment.center
        }
    }
    
    private func addTargets() {
        startPicker.addTarget(self, action: #selector(startAction), for: UIControlEvents.valueChanged)
        endPicker.addTarget(self, action: #selector(endAction), for: UIControlEvents.valueChanged)
    }
}

extension TwoBarButtonsVC: UIPickerViewDelegate {
    
    @IBAction func buttonsPressed(_ sender: UIButton) {
        
        if modelManager.currentModel?.buttonModels?[0].title == "START" {
            if sender.tag == 0 {
                startPicker.isHidden = false
            } else {
                endPicker.isHidden = false
            }
            nextButton.isHidden = true
        } else {
            if let text = sender.titleLabel?.text {
                let transitionHandler = TransitionHandler(currentExamViewController: self)
                transitionHandler.decideCourse(data: text)
            }
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let startDate = startDate, let endDate = endDate {
            let transitionHandler = TransitionHandler(currentExamViewController: self)
            transitionHandler.decideCourse(data: "\(startDate) - \(endDate)")
        }
    }
    
    @objc func startAction() {
        let date = dateToString(date: startPicker.date)
        startDate = date
        
        firstButton.setTitle(date, for: .normal)
        startPicker.isHidden = true
        
        dateHasBeenSet.start = true
        nextExamButton()
    }
    
    @objc func endAction() {
        let date = dateToString(date: endPicker.date)
        endDate = date
        secondButton.setTitle(date, for: .normal)
        endPicker.isHidden = true
        
        dateHasBeenSet.end = true
        nextExamButton()
    }
    
    private func nextExamButton() {
        if dateHasBeenSet == (true, true) {
            nextButton.isHidden = false
        }
    }
    
    func dateToString(date: Date) -> String {
      return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
}
