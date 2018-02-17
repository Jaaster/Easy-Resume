//
//  ExamModel.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class ModelExam {
    
    var exam: Exam
    var type: Type
    var title: String
    var color: UIColor
    var buttonModels: [ModelButton]?
    // MARK: - Only needed if the type variable of ModelExam is of type .description 
    var descriptions: [String]?
    unowned var parentModelExamManager: ModelManager<ModelExam>
    weak var childModelExamManager: ModelManager<ModelExam>?
    
    init(exam: Exam, type: Type, title: String, color: UIColor, buttonModels: [ModelButton]? = nil, parentModelExamManager: ModelManager<ModelExam> ,childModelExamManager: ModelManager<ModelExam>? = nil, descriptions: [String]? = nil) {
        self.exam = exam
        self.type = type
        self.title = title
        self.color = color
        self.buttonModels = buttonModels
        self.parentModelExamManager = parentModelExamManager
        self.childModelExamManager = childModelExamManager
        self.descriptions = descriptions
    }
}

extension ModelExam: Managable {}
extension ModelExam: Equatable {
    
    static func ==(lhs: ModelExam, rhs: ModelExam) -> Bool {
        if lhs.title != rhs.title {
            return false
        }
        if lhs.exam != rhs.exam {
            return false
        }
        if lhs.type != rhs.type {
            return false
        }
        return true
    }
}
