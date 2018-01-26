//
//  Loadable.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/17/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

protocol Loadable: Animatable {
    func load()
    func unload()
}

extension Loadable where Self: UIView {
    
    func load() {
        UIView.animate(withDuration: time, animations: {
            self.transform = CGAffineTransform(scaleX: 5, y: 5)
        })
    }
    
    func unload() {
        UIView.animate(withDuration: time, animations: {
            self.transform = CGAffineTransform.identity
            
        })
    }
    
    func loadThenUpdate(vc: LoadableVC) {
        UIView.animate(withDuration: time, animations: {
            self.transform = CGAffineTransform(scaleX: 5, y: 5)
        }, completion: { _ in
            self.unload()
            UpdateViews().update(destinationVC: vc)
        })
    }
    
}

