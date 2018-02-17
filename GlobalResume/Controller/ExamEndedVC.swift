//
//  ExamEndedVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/29/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import ConfettiView
class ExamEndedVC: UIViewController, ExamViewController {
   
    var modelManager: ModelManager<ModelExam>!
    var gender: Gender!

    @IBOutlet weak var applicantImage: BobbingImageView!
    @IBOutlet weak var interviewerImage: BobbingImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var btn: CustomButton!
    @IBOutlet weak var confettiVIew: ConfettiView!
    @IBOutlet weak var applicantsShadowImage: ExpandableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViewsWithNewData() {
        if gender == nil {
            gender = Gender.male
        }
        
        confettiVIew.startAnimating()

        let color = UIColor.myBlue
        titleLabel.textColor = color
        titleLabel.text = "SUCCESS!"
        
        secondTitleLabel.textColor = color
        secondTitleLabel.text = "You are now ready to apply for a job!"
        
        btn.backgroundColor = color
        btn.titleLabel?.textColor = UIColor.white
        btn.round(scale: 7.5)
        btn.setTitle("View Resume", for: .normal)
        
        interviewerImage.image = UIImage(named: "INTERVIEWER")
        applicantImage.image = UIImage(named: "APPLICANT\(gender.rawValue)")
        
        applicantImage.toggleBobbing()
        applicantsShadowImage.toggleExpansion()        
    }
    
    @IBAction func btnPressed(sender: CustomButton) {
        let transitionHandler = TransitionHandler(currentExamViewController: self)
        transitionHandler.decideCourse(data: nil)
    }
}
