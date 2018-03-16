//
//  ExamModelManager.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

protocol ModelManaging {
    associatedtype model: Managable
    var currentModel: model? { get set }
    var models: [model]? { get set }
    var childModelManager: ModelManager<model>? { get set }
    func modelAfter(model: model) -> model?
    func get(at index: Int) -> model?
}

protocol Managable { }

class ModelManager<model: Managable>: ModelManaging {
    var childModelManager: ModelManager<model>?
    var currentModel: model?
    private var lastFoundElement: model?
    
    var models: [model]? {
        willSet {
            currentModel = newValue?.first
        }
    }
}

extension ModelManaging where model == ExamModel {
    func modelFrom(exam: Exam) -> model? {
        guard let models = models else {return nil}
        for model in models {
            if model.exam == exam {
                return model
            }
        }
        return nil
    }
}

extension ModelManager {
    
    func modelAfter(model: model) -> model? {
        if let index = models?.index(where: { (object) -> Bool in
            if let object = object as? ExamModel, let model = model as? ExamModel {
                if object == model {
                    return true
                }
            }
            return false
        }) {
            let nextIndex = index+1
            if nextIndex < models!.count {
                return get(at: nextIndex)
            }
        }
        return nil
    }
    
    func get(at index: Int) -> model? {
        if index < models!.count {
            let model = models?[index]
            lastFoundElement = model
            return model
        }
        return nil
    }
    
    func resetCurrentModel() {
        currentModel = models?.first
    }
    
    func lastFoundElementOfModel() -> model?{
        return lastFoundElement
    }
}
