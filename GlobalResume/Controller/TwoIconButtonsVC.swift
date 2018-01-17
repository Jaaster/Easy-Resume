//
//  TwoIconButtonsVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class TwoIconButtonsVC: UIViewController, Loadable {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var firstCircleView: CircleView!
    @IBOutlet weak var secondCircleView: CircleView!
    
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    
    @IBOutlet weak var firstIconImageView: UIImageView!
    @IBOutlet weak var secondIconImageView: UIImageView!
    var loadingViewColor: UIColor!

    var currentExam: Exam!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Animations().load(seconds: 0.7, vc: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Exam.Kind.input.rawValue {
            if let destination = segue.destination as? InputVC {
                destination.currentExam = sender as! Exam
                destination.loadingViewColor = loadingView.backgroundColor

            }
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            //Top save data
            loadingView.backgroundColor = firstCircleView.backgroundColor
        } else {
            //Bottom save data
            loadingView.backgroundColor = secondCircleView.backgroundColor

        }
        
        
        
        if currentExam.next().kind() != currentExam.kind() {
            //Needs to exicute segue
            Animations().performSegue(vc: self, withIdentifier: currentExam.next().kind().rawValue, sender: currentExam.next())
        } else {
            //stay and update
        }

        
    }
    func defaultLoadingViewColor() {
        loadingViewColor = currentExam.getValues().color.getUIColor()
    }
        
}
