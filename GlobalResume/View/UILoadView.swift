//
//  UILoadView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/17/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class UILoadView: UIView, Loadable {
    
    private var _time = 0.7
    
    var time: Double {
        get {
            return _time
        }
        set {
            _time = newValue
        }
    }
}
