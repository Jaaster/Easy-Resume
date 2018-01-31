//
//  CustomView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

protocol LoadableVC: class {
    
    var currentExam: Exam! { get set }
    func updateData()
}

