//
//  ExamModel.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class ExamModel {
    
    var exam: Exam
    var type: VCType
    var title: String
    var color: UIColor
    var buttonModels: [ButtonModel]?
    // NOTE: - Only needed if the type variable of ModelExam is of type .description
    var descriptions: [String]?
    var subModelManager: ModelManager<ExamModel>?
    
    init(exam: Exam, type: VCType, buttonModels: [ButtonModel]? = nil, descriptions: [String]? = nil) {
        self.exam = exam
        self.type = type
        self.title = exam.rawValue
        self.color = UIColor.darkGray
        self.buttonModels = buttonModels
        self.descriptions = descriptions
    }
}

extension ExamModel: Managable {}
extension ExamModel: Equatable {
    
    static func ==(lhs: ExamModel, rhs: ExamModel) -> Bool {
        return lhs.exam == rhs.exam
    }
}
