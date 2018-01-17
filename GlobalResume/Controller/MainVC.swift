//
//  ViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class MainVC: UIViewController, Loadable {

    @IBOutlet weak var loadAppImageView: UIImageView!
    @IBOutlet weak var loadingView: UIView!
    var loadingViewColor: UIColor!
    var currentExam: Exam!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Animations().fadeOut(view: loadAppImageView, seconds: 3.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateResume" {
            if let destination = segue.destination as? InputVC {
                destination.currentExam = sender as! Exam
                destination.loadingViewColor = loadingView.backgroundColor
            }
        }
    }
    
    @IBAction func buttonPressed(button: UIButton) {
        if button.tag == 0 {
            //Create button Pressed
            loadingView.backgroundColor = Color.blue.getUIColor()
            Animations().performSegue(vc: self, withIdentifier: "CreateResume", sender: Exam.name)
        } else {
            //Edit Button Pressed
        }
    
    }
    func defaultLoadingViewColor() {
        loadingViewColor = currentExam.getValues().color.getUIColor()
    }
    


}






