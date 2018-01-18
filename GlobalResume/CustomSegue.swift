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
                        loadableDestination.currentExam = currentExam.next()!
                }
                    loadableDestination.loadingViewColor = loadableSource.loadingView.backgroundColor
                
                
                
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