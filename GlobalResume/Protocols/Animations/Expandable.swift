//
//  Expandable.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/29/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation
import UIKit
protocol Expandable: Animatable {
    var toggle: Bool { get set }
    mutating func toggleExpansion()
}

extension Expandable where Self: UIView {
    
    private func animation(big: Bool) {
        if toggle {
            UIView.animate(withDuration: time, animations: {
                if big {
                    self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                } else {
                    self.transform = CGAffineTransform.identity
                }
            }, completion: { _ in
                self.animation(big: !big)
            })
        }
    }
    
    mutating func toggleExpansion() {
        toggle = !toggle
        animation(big: true)
    }
}
