//
//  ViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class MainVC: UIViewController, ExamViewController {
    
    // MARK: Already Initialized Variables
    var modelManager: ModelManager<ModelExam>!
    var dataHandler: ResumeDataHandler!
    @IBOutlet weak var firstCircleView: CircleView!
    @IBOutlet weak var secondCircleView: CircleView!
    @IBOutlet weak var createLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    
    var currentExam: Exam!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentExam = Exam.menu
        updateViewsWithNewData()
        setupViews()
    }
    
    func setupViews() {
        firstCircleView.round()
        secondCircleView.round()
    }
    
    func updateViewsWithNewData() {
        var color = UIColor.myBlue
        if dataHandler.resumeList == nil {
           color = UIColor.myGrey
        }
        
        secondCircleView.backgroundColor = color
        createdLabel.textColor = color
    }
    
    @IBAction func buttonPressed(button: UIButton) {
        if button.tag == 0 {
            //Create button Pressed
            let transitionHandler = TransitionHandler(currentExamViewController: self)
            transitionHandler.decideCourse(data: nil)
        } else {
            //Edit Button Pressed
            guard let resumeList = dataHandler.resumeList else {
                return
            }
            if resumeList.isEmpty {
                return
            }
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "CHOOSE_RESUME")
                present(vc, animated: true, completion: nil)
        }
    }
}
