//
//  TwoBarButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/23/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class TwoBarButtonsVC: UIViewController, LoadableVC {
    
    var currentExam: Exam!
    var presenting: UIViewController!
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
        handlePreviousController()
        addTargets()
    }
    
    func updateData() {
        
        let values = currentExam.getValues()
        let color = values.color

        iconImageView.image = UIImage(named: currentExam.rawValue)
        titleLabel.text = currentExam.rawValue
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
        let buttonDataFromExam = currentExam.getValues().buttons
        
        for i in 0..<buttonArray.count {
            let button = buttonArray[i]
            button?.setTitle(buttonDataFromExam[i].name, for: .normal)
            button?.backgroundColor = buttonDataFromExam[i].color
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
        
        if currentExam.getValues().buttons[0].name == "START" {
            if sender.tag == 0 {
                startPicker.isHidden = false
            } else {
                endPicker.isHidden = false
            }
            nextButton.isHidden = true
        } else {
            if let text = sender.titleLabel?.text {
                handleTransportation(data: text)
            }
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let startDate = startDate, let endDate = endDate {
            handleTransportation(data: "\(startDate) - \(endDate)")
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