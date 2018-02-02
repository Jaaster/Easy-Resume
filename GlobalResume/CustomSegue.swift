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
            if let sourceExam = loadableSource.currentExam {
                if let trigger = OneInstance.shared.trigger {
                    if let nextExam = trigger.next(exam: sourceExam) {
                        loadableDestination.currentExam = nextExam
                    } else {
                        //was triggered and hasn't set the value of current exam to first trigger
                        if let firstExam = trigger.examList().first {
                            loadableDestination.currentExam = firstExam
                            
                        }
                    }
                    
                } else {
                    //Normal exam
                    if let nextExam = sourceExam.next() {
                        loadableDestination.currentExam = nextExam
                    }
                    
                }
                
            }
        }
        source.present(destination, animated: true, completion: nil)
    }
    
}

