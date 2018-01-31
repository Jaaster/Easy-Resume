//
//  CustomSegue.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/17/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import CoreData
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
                    if let nextExam = currentExam.next() {
                        loadableDestination.currentExam = nextExam
                    }
                }
                
            }
        }
        
        source.view.fadeSubviews(alpha: 1.0, completion: {
            source.present(destination, animated: false, completion: {
                for subVew in destination.view.subviews {
                        subVew.alpha = 0.0
                }
                destination.view.fadeSubviews(alpha: 1.0)
                
            
            })
        })
    }
    
}

