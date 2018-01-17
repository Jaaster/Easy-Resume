//
//  InputVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class InputVC: UIViewController, UITextFieldDelegate, Loadable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var loadingView: UIView!
    var loadingViewColor: UIColor!
    var currentExam: Exam!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        Animations().load(seconds: 0.7, vc: self)
        
    }

    func saveData() {
        if let data = textField.text {
            
            
        } else {
            print("No data")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Exam.Kind.twoButtons.rawValue {
            if let destination = segue.destination as? TwoIconButtonsVC {
                destination.currentExam = sender as! Exam
                destination.loadingViewColor = loadingView.backgroundColor

            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //add new data to model
        saveData()
        
        loadingView.backgroundColor = currentExam.getValues().color.getUIColor()
        if currentExam.next().kind() == Exam.Kind.input {
            //Stay and update current view
            currentExam = currentExam.next()
            Animations().load(seconds: 0.7, vc: self)
        } else if currentExam.next().kind() != currentExam.kind() {
            //Perform segue
            Animations().performSegue(vc: self, withIdentifier: currentExam.next().kind().rawValue, sender: currentExam.next())
        }
        
       
        
        return true
    }
    func defaultLoadingViewColor() {
        loadingViewColor = currentExam.getValues().color.getUIColor()
    }
    
   

}


