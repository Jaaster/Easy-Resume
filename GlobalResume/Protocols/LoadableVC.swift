//
//  CustomView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

protocol LoadableVC {
    
    weak var loadingView: UIView! { get set }
    var loadingViewColor: UIColor! { get set }
    var currentExam: Exam! { get set }
    
    func defaultLoadingViewColor()
    func prepare(for segue: UIStoryboardSegue, sender: Any?) 
    
}


