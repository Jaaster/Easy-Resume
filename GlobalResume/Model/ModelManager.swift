//
//  ExamModelManager.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/9/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

protocol ModelManaging {
    associatedtype model
    var currentModel: model? { get set }
    var models: [model]? { get }
    func modelAfter(model: model) -> model?
    func get(at index: Int) -> model?
}

protocol Managable {}

class ModelManager<model: Managable>: ModelManaging {
    var currentModel: model?
    private var lastFoundElement: model?
    var models: [model]?
    
    func setValues(models: [model]?, currentModel: model?) {
        self.models = models
        self.currentModel = currentModel
    }
}

extension ModelManager {
    
    func modelAfter(model: model) -> model? {
        if let index = models?.index(where: { (object) -> Bool in
            if let object = object as? ModelExam, let model = model as? ModelExam {
                if object == model {
                    return true
                }
            }
            return false
        }) {
            let nextIndex = index+1
            if nextIndex < models!.count {
                return models?[nextIndex]
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
