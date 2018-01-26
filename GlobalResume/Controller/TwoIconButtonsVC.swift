//
//  TwoIconButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class TwoIconButtonsVC: UIViewController, LoadableVC {

    @IBOutlet weak var loadingView: LoadView!
    @IBOutlet weak var firstCircleButton: CircleButton!
    @IBOutlet weak var secondCircleButton: CircleButton!
    
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    
    @IBOutlet weak var firstIconImageView: UIImageView!
    @IBOutlet weak var secondIconImageView: UIImageView!
    var loadingViewColor: UIColor!

    var currentExam: Exam!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.backgroundColor = loadingViewColor
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let text: String
        if sender.tag == 0 {
            text = firstTitleLabel.text!
        } else {
            text = secondTitleLabel.text!
        }
        loadingView.backgroundColor = sender.backgroundColor
        handleTransportation(data: text)
    }
    
}
