//
//  ViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class MainVC: UIViewController, LoadableVC {
    
    @IBOutlet weak var loadAppImageView: LoadAppView!
    @IBOutlet weak var firstCircleView: CircleView!
    @IBOutlet weak var secondCircleView: CircleView!
    
    @IBOutlet weak var loadingView: LoadView!
    var loadingViewColor: UIColor!
    var currentExam: Exam!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentExam = Exam.menu
        loadAppImageView.fade(alpha: 0.0)
        UpdateViews().update(destinationVC: self)
        
        FIRFirebaseService.shared.updateExamples(for: .examples, for: .jobs)
        
    }
    
    
    @IBAction func buttonPressed(button: UIButton) {
        if button.tag == 0 {
            //Create button Pressed
            loadingView.backgroundColor = Color.blue.getUIColor()
            handleTransportation(data: "")
        } else {
            //Edit Button Pressed
        }
        
    }
    
    
}
