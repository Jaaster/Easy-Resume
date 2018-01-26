//
//  TwoBarButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/23/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class TwoBarButtonsVC: UIViewController, LoadableVC {
    
    @IBOutlet var loadingView: LoadView!
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var loadingViewColor: UIColor!
    var currentExam: Exam!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.backgroundColor = loadingViewColor
    }
    
    @IBAction func buttonsPressed(_ sender: UIButton) {
        loadingView.backgroundColor = sender.backgroundColor
        handleTransportation(data: (sender.titleLabel?.text!)!)
    }
    
}

