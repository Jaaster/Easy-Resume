//
//  LoadableVCExtension.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/30/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
extension LoadableVC where Self: UIViewController {
    
    
    func handleTransportation(data: String) {
        
        
        //End of exam
        if currentExam == nil {
            self.performSegue(withIdentifier: "MENU", sender: nil)
            return
        }
        //Loop hole need to fix...User can the name of a button that calls a trigger it will call it
        
        let instance = OneInstance.shared
        
        if !instance.isTriggered {
            //Not triggered
            if let trigger = Trigger(rawValue: data) {
                //If the data is a a trigger
                instance.isTriggered = true
                instance.trigger = trigger
                instance.examBeforeTrigger = currentExam
                
                //First Exam of Trigger
                //Create a new Model for the Trigger
                ResumeDataHandler.shared.updateData(for: trigger, exam: currentExam, data: data)
            
                
                //Get the exam for the first trigger
                if let triggerExam = trigger.next(exam: nil) {
                    currentExam = triggerExam
                    handleSegues(currentExamKind: instance.examBeforeTrigger.kind(), nextExam: triggerExam)
                } else {
                    print("Data is a trigger, trigger does not any exams :(")
                }
            } else {
                //Normal segue
                if let nextExam = currentExam.next() {
                    handleSegues(currentExamKind: currentExam.kind(), nextExam: nextExam)
                } else {
                    //End of Exams
                    PersistantService.saveContext()
                    self.performSegue(withIdentifier: "EXAM_ENDED", sender: nil)
                }
                if currentExam == Exam.menu {
                    return
                }
                ResumeDataHandler.shared.updateData(dataType: currentExam, data: data)

            }
        } else {
            //Is triggered
            let trigger = instance.trigger
            
            ResumeDataHandler.shared.updateData(for: trigger, exam: currentExam, data: data)

            
            if let nextExam = trigger.next(exam: currentExam) {
                //trigger has next exam
                handleSegues(currentExamKind: currentExam.kind(), nextExam: nextExam)
            } else {
                //End of trigger
                let beforeExam = instance.examBeforeTrigger
                
                instance.isTriggered = false
                if let nextExam = beforeExam.next() {
                    let kind = currentExam.kind()
                    currentExam = beforeExam
                    handleSegues(currentExamKind: kind, nextExam: nextExam)
                }
                ResumeDataHandler.shared.putEmploymentAndEducationInResume()
            }
            
        }
        
        
        
    }
    
    private func handleSegues(currentExamKind: Exam.Kind, nextExam: Exam) {
        let nextKind = nextExam.kind()
        if nextKind == currentExamKind {
            //Stay and update current view
            self.currentExam = nextExam
            view.fadeSubviews(alpha: 0.0, completion: {
                self.updateData()
                self.view.fadeSubviews(alpha: 1.0)
            })
        } else {
            self.performSegue(withIdentifier: nextKind.rawValue, sender: nil)
        }
    }
}
