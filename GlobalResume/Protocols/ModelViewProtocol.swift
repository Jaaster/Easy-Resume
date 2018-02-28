//
//  ModelView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

protocol ModelViewProtocol {
    var exam: ExamModel { get set }
    func updateViews()
}
