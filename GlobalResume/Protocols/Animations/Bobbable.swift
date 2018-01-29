//
//  Bobbable.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/29/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation
import UIKit

protocol Bobbable: Animatable {
    var toggle: Bool { get set }
    mutating func toggleBobbing()
}

extension Bobbable where Self: BobbingImageView {
   
    private func animation(up: Bool) {
        if toggle {
            UIView.animate(withDuration: time, animations: {
                if up {
                    self.transform = CGAffineTransform(translationX: 0, y: -50)
                } else {
                    self.transform = CGAffineTransform.identity
                }
            }, completion: { _ in
                self.animation(up: !up)
            })
        }
    }
    
    mutating func toggleBobbing() {
        toggle = !toggle
        animation(up: true)
    }
   
}
