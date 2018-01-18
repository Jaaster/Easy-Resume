//
//  CustomView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

protocol LoadableVC: class {
    
    weak var loadingView: UILoadView! { get set }
    var loadingViewColor: UIColor! { get set }
    var currentExam: Exam! { get set }    
}

extension LoadableVC where Self: UIViewController {
    
    
    func handleTransportation(dataType: Exam, data: String) {
        ResumeData.shared.updateData(dataType: dataType, data: data)
        
        if let nextExam = dataType.next() {
         let currentKind = currentExam.kind()
         let nextKind = nextExam.kind()
        
            if nextKind == currentKind {
                //Stay and update current view
                currentExam = nextExam
                loadingView.loadThenUpdate(vc: self)
            } else {
                //Perform segue
                self.performSegue(withIdentifier: nextKind.rawValue, sender: nextExam)
            }
        }
        
    }
}
