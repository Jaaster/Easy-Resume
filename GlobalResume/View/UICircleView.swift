//
//  CircleView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
protocol Roundable {}

class UICircleView: UIView, Roundable {}

extension Roundable where Self: CircleView {
    func round() {
        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = true
    }
}
