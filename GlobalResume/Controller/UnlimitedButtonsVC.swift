//
//  UnlimitedButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class UnlimitedButtonsVC: UIViewController, LoadableVC {
   
    var loadingViewColor: UIColor!
    var currentExam: Exam!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var circleView: UICircleView!
    @IBOutlet weak var loadingView: UILoadView!
    
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.backgroundColor = loadingViewColor
    }
    
    @IBAction func buttonsPressed(_ sender: UIButton) {
        loadingView.backgroundColor = sender.backgroundColor
        handleTransportation(data: (sender.titleLabel?.text!)!)
    }
    
    
}
