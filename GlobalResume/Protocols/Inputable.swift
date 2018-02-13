//
//  Inputable.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/10/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

@objc protocol Inputable {
    var textField: UITextField! { get set }
    
    @objc func doneButtonPressed()
}
