//
//  Loadable.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/17/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

protocol Loadable: Animatable {
    func load(completion: @escaping () -> ())
    func unload()
}

extension Loadable where Self: UIView {
    
    func load(completion: @escaping () -> ()) {
        UIView.animate(withDuration: time, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: { _ in
            completion()
        })
    }
    
    func unload() {
        UIView.animate(withDuration: time, animations: {
            self.center = CGPoint(x: self.superview!.center.x, y: self.frame.height*2)
        }, completion: {
            _ in
            print("unload complete")
            self.load { print("load complete")}
        })
    }
    
}

