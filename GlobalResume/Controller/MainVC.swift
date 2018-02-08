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
    let shared = ResumeDataHandler.shared
    override func viewDidLoad() {
        super.viewDidLoad()
       
        currentExam = Exam.menu
        
        updateData()
        setupViews()
        handlePreviousController()
    }
    
    func setupViews() {
        firstCircleView.round()
        secondCircleView.round()
    }
    
    func updateData() {
        var color = UIColor.myBlue
        if shared.getCoreDataResumeList() == nil {
           color = UIColor.myGrey
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
            guard let resumeList = shared.getCoreDataResumeList() else {
                return
            }
            if resumeList.isEmpty {
                return
            }
                shared.isEditingResume = true
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "CHOOSE_RESUME")
                present(vc, animated: true, completion: nil)
        }
    }
}

