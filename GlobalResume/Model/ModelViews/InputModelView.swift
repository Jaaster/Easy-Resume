//
//  InputModelView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class InputModelView: ModelViewProtocol {
    var exam: ModelExam
    var iconImageName: String?
    
    init(exam: ModelExam) {
        self.exam = exam
        iconImageName = exam.title
    }
}

extension InputModelView {
    func updateViews() {
        
    }
}

extension InputModelView {
    func getColor() -> UIColor {
        return exam.color
    }
    
    func getTitle() -> String {
        return exam.title
    }

    func getImageName() -> String {
        guard let iconImageName = iconImageName else {
            return ""
        }
        return iconImageName
    }
}
