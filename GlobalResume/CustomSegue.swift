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
            //Animation for Segue
            
            
            var fadeTime = 0.4
            if source is MainVC {
                fadeTime = 0.8
            }
            
            loadableSource.loadingView.backgroundColor = UIColor.white
            loadableSource.loadingView.time = fadeTime
            loadableSource.loadingView.fade(alpha: 1.0, completion: {
                source.present(destination, animated: false, completion: {
                    loadableDestination.loadingView.backgroundColor = UIColor.white
                    loadableDestination.loadingView.time = fadeTime
                    loadableDestination.loadingView.fade(alpha: 0.0)
                    
                })
            })
            
        }
    }
    

    
}

