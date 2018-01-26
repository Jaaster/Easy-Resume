//
//  CustomView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

protocol LoadableVC: class {
    
    weak var loadingView: LoadView! { get set }
    var loadingViewColor: UIColor! { get set }
    var currentExam: Exam! { get set }
}

extension LoadableVC where Self: UIViewController {
    
    func handleTransportation(data: String) {
        ResumeData.shared.updateData(dataType: currentExam, data: data)
        //Loop whole need to fix...User can the name of a button that calls a trigger it will call it
        
        
        let instance = OneInstance.shared
        
        if !instance.isTriggered {
            //Not triggered
            if let trigger = Trigger(rawValue: data) {
                //If the data is a a trigger
                instance.isTriggered = true
                instance.trigger = trigger
                instance.examBeforeTrigger = currentExam
                //Get the exam for the trigger
                if let triggerExam = trigger.next(exam: nil) {
                    currentExam = triggerExam
                    handleSegues(currentExam: instance.examBeforeTrigger, nextExam: triggerExam)
                } else {
                    print("Data is a trigger, trigger does not any exams :(")
                }
            } else {
                //Normal segue
                if let nextExam = currentExam.next() {
                    handleSegues(currentExam: currentExam, nextExam: nextExam)
                }
            }
        } else {
            //Is triggered
            let trigger = instance.trigger
            
            if let nextExam = trigger.next(exam: currentExam) {
                //trigger has next exam
                handleSegues(currentExam: currentExam, nextExam: nextExam)
            } else {
                //End of trigger
                let beforeExam = instance.examBeforeTrigger
                instance.isTriggered = false
                if let nextExam = beforeExam.next() {
                    handleSegues(currentExam: currentExam, nextExam: nextExam)
                }
            }
            
        }
        
        
        
    }
    
    private func handleSegues(currentExam: Exam, nextExam: Exam) {
        let currentKind = currentExam.kind()
        let nextKind = nextExam.kind()
        if nextKind == currentKind {
            //Stay and update current view
            self.currentExam = nextExam
            loadingView.loadThenUpdate(vc: self)
        } else {
            //Perform segue
            self.performSegue(withIdentifier: nextKind.rawValue, sender: currentExam)
        }
        
    }
}

