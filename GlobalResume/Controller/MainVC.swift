//
//  ViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class MainVC: UIViewController, LoadableVC {
    
    var presenting: UIViewController!
    
    @IBOutlet weak var firstCircleView: CircleView!
    @IBOutlet weak var secondCircleView: CircleView!
    
    @IBOutlet weak var createLabel: UILabel!
    
    @IBOutlet weak var createdLabel: UILabel!
    
    var currentExam: Exam!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentExam = Exam.menu
        updateData()
        if presenting == nil {
            presenting = UIViewController()
        }
        presenting.dismiss(animated: false, completion: nil)
    }
    
    func updateData() {
        firstCircleView.round()
        secondCircleView.round()
        
        var color = Color.blue.getUIColor()
        if ResumeDataHandler.shared.getResumeList() == nil {
           color = Color.grey.getUIColor()
        }
        
        secondCircleView.backgroundColor = color
        createdLabel.textColor = color
    }
    
    @IBAction func buttonPressed(button: UIButton) {
        if button.tag == 0 {
            //Create button Pressed
            handleTransportation(data: "")
        } else {
            //Edit Button Pressed
            if ResumeDataHandler.shared.getResumeList() != nil {
                ResumeDataHandler.shared.editingResume = true
               let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "CHOOSE_RESUME")
                present(vc, animated: true, completion: nil)
            }
        }
        
    }
}

