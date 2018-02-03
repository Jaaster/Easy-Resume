//
//  ViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class MainVC: UIViewController, LoadableVC {
    
    @IBOutlet weak var loadAppImageView: UIImageView!
    @IBOutlet weak var firstCircleView: CircleView!
    @IBOutlet weak var secondCircleView: CircleView!
    
    var currentExam: Exam!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentExam = Exam.menu
        loadAppImageView.fade(alpha: 0.0)
        updateData()
    }
    
    func updateData() {
        firstCircleView.round()
        secondCircleView.round()
        
        if ResumeDataHandler.shared.getResumeList() != nil {
            secondCircleView.backgroundColor = Color.blue.getUIColor()
        }
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

