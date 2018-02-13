//
//  ExamViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

protocol ExamViewController: class {
    var modelManager: ModelManager<ModelExam>! { get set }
    var dataHandler: ResumeDataHandler! { get set }
    func updateViewsWithNewData()
}
