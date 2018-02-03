//
//  ExamEndedVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/29/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import ConfettiView
class ExamEndedVC: UIViewController, LoadableVC {
   
    var currentExam: Exam!
    
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

    func updateData() {
        
        confettiVIew.startAnimating()
        let color = Color.blue.getUIColor()
        titleLabel.textColor = color
        titleLabel.text = "SUCCESS!"
        
        secondTitleLabel.textColor = color
        secondTitleLabel.text = "You are now ready to apply for a job!"
        
        
        btn.backgroundColor = color
        btn.titleLabel?.textColor = UIColor.white
        btn.round(scale: 7.5)
        btn.setTitle("View Resume", for: .normal)
        interviewerImage.image = UIImage(named: "INTERVIEWER")
        applicantImage.image = UIImage(named: "APPLICANT\(ResumeDataHandler.shared.gender())")
        
        applicantImage.toggleBobbing()
        applicantsShadowImage.toggleExpansion()
        
        ResumeDataHandler.shared.currentResume = nil
    }
    @IBAction func btnPressed(sender: CustomButton) {
        handleTransportation(data: "")
    }
 
    
}
