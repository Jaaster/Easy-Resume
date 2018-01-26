//
//  CustomSegue.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/17/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        scale()
    }
    
    func scale() {
        let source = self.source
        let destination = self.destination
        
        if let loadableSource = source as? LoadableVC, let loadableDestination = destination as? LoadableVC {
            if let currentExam = loadableSource.currentExam {
                if OneInstance.shared.isTriggered {
                    if let beforeExam = OneInstance.shared.trigger.isFirst(exam: currentExam) {
                        //Is First Exam of Trigger
                        loadableDestination.currentExam = beforeExam
                    } else if let nextExam = OneInstance.shared.trigger.next(exam: currentExam) {
                        loadableDestination.currentExam = nextExam
                    }
                    
                } else {
                    //Normal exam
                    loadableDestination.currentExam = currentExam.next()!
                }
                
            }
            loadableDestination.loadingViewColor = loadableSource.loadingView.backgroundColor
            
            //Animation for Segue
            
            UIView.animate(withDuration: 0.7, animations: {
                loadableSource.loadingView.transform = CGAffineTransform(scaleX: 5, y: 5)
            }, completion: { _ in
                
                source.present(destination, animated: false, completion: {
                    loadableSource.loadingView.backgroundColor = UIColor.clear
                    loadableDestination.loadingView.time = 0.0
                    loadableDestination.loadingView.loadThenUpdate(vc: loadableDestination)
                    loadableDestination.loadingView.time = 0.7
                })
            })
        }
        
        
    }
    
    
    
}

