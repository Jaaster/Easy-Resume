//
//  TwoBarButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/23/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class TwoBarButtonsVC: UIViewController, LoadableVC {
    
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //DatePickers
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!

    var currentExam: Exam!
    
    var dateSet = (false, false)
 
    override func viewDidLoad() {
        super.viewDidLoad()
        events()
    }
    override func loadView() {
        super.loadView()
        updateData()
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
        startPicker.backgroundColor = color
        endPicker.backgroundColor = color
        nextButton.backgroundColor = color

        nextButton.isHidden = true
        let buttonArray = [firstButton, secondButton]
        
        for i in 0..<buttonArray.count {
            let button = buttonArray[i]
            button?.setTitle(buttons[i].name, for: .normal)
            button?.backgroundColor = buttons[i].color.getUIColor()
            button?.titleLabel?.textAlignment = NSTextAlignment.center
            
        }
    }
    
    @IBAction func buttonsPressed(_ sender: UIButton) {

        if currentExam.getValues().buttons[0].name == "START" {
            if sender.tag == 0 {            
                startPicker.isHidden = false
            } else {
                endPicker.isHidden = false
            }
            nextButton.isHidden = true
        } else {
            handleTransportation(data: (sender.titleLabel?.text!)!)
        }
    }
    
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        handleTransportation(data: firstButton.titleLabel!.text! + " - " + secondButton.titleLabel!.text!)
    }
    
}

extension TwoBarButtonsVC: UIPickerViewDelegate {
   
    func events() {
        startPicker.addTarget(self, action: #selector(startEvent), for: UIControlEvents.valueChanged)
        endPicker.addTarget(self, action: #selector(endEvent), for: UIControlEvents.valueChanged)
    }
    
    @objc func startEvent() {
        firstButton.setTitle(dateToString(date: startPicker.date), for: .normal)
        startPicker.isHidden = true
        dateSet = (true, dateSet.1)
        nextExamButton()

    }
    
    @objc func endEvent() {
        secondButton.setTitle(dateToString(date: endPicker.date), for: .normal)
        endPicker.isHidden = true
        dateSet = (dateSet.0, true )
        nextExamButton()
    }
    
    func nextExamButton() {
        if dateSet == (true, true) {
            nextButton.isHidden = false
        }
    }
    
    func dateToString(date: Date) -> String {
      return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
}

