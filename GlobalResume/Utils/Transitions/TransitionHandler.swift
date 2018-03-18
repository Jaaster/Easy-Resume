//
//  TransportationService.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/11/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
// MARK: - This Struct manages the current view controller and the current state of the application and decides what view should be displayed next
class TransitionHandler {

    // MARK: Initializing variables
    private var examEnded: Bool = false
    private var currentModelExam: ExamModel
    private var navigationController: CustomNavigationController
    private var modelManager: ModelManager<ExamModel>
    private var isEditingCurrentResume: Bool
    
    init(navigationController: CustomNavigationController) {
        self.navigationController = navigationController
        modelManager = navigationController.modelManager
        isEditingCurrentResume = navigationController.isEditingCurrentResume
        if let currentModel = modelManager.currentModel {
            currentModelExam = currentModel
        } else {
            examEnded = true
            
            // TODO: get rid of this ugly thing
            currentModelExam = ExamModel(exam: Exam.name, type: VCType.informationInput)
        }
    }
}

extension TransitionHandler {
    
    // MARK: - Decides if the view controller should present/dismiss or reload views
    func decideCourse(data: String?) {
        
        if isEditingCurrentResume {
            // Just pop the current view controller as we do not need to continue through the list of ExamModels
            handleData(currentExam: currentModelExam.exam, data: data)
            navigationController.popViewController(animated: true)
            return
        }
        
            // MARK: - Has childModelManager, which means we need to start going through its collection of models
        if let childModelManager = currentModelExam.subModelManager {
            // MARK: - Start going through the models in the child model manager
            if let models = childModelManager.models {
                transitionOrUpdate(nextModelExam: models.first!, data: data)
                return
            }
        }
        
        if let currentModelsManager = getParentModelManager(modelExam: currentModelExam) {
            // MARK: - This model does not have the same manager
            if currentModelsManager !== modelManager {
                if let nextModelExam = currentModelsManager.modelAfter(model: currentModelExam) {
                    transitionOrUpdate(nextModelExam: nextModelExam, data: data)
                    return
                } else {
                    if let nextExamModel = modelManager.modelAfter(model: modelManager.lastFoundElementOfModel()!) {
                        transitionOrUpdate(nextModelExam: nextExamModel, data: data)
                        return
                    }
                }
            }
        }
        
        // MARK: - Has another exam after the current one
        if let nextExamModel = modelManager.modelAfter(model: currentModelExam) {
            // MARK: - If the next exam requires that the view controller change
           transitionOrUpdate(nextModelExam: nextExamModel, data: data)
            return
        } else {
            // MARK: - Dismiss To the root View Controller is manditory after the user has completed creating the resume
            popToRootViewController()
            // MARK: - Resetsa the current model to the first one, which is the main/menu
            modelManager.resetCurrentModel()
        }
    }
    
    // MARK: - Takes the next model exam to be presented and the data entered by the user for the previous exam.
    func transitionTo(nextModelExam: ExamModel, data: String?) {
        handleData(currentExam: currentModelExam.exam, data: data)
        
        let nextViewController = getViewController(for: nextModelExam.type)
        
        modelManager.currentModel = nextModelExam
        navigationController.pushViewController(nextViewController, animated: true)
    }
}

private extension TransitionHandler {
    
    // MARK: - Decides whether presenting a new view controller or updating the current view controller should take place
    func transitionOrUpdate(nextModelExam: ExamModel, data: String?) {
        if shouldTransition(type: nextModelExam.type) {
            transitionTo(nextModelExam: nextModelExam, data: data)
        } else {
            updateCurrentViewController(to: nextModelExam, data: data)
        }
    }
    
    func popToRootViewController() {
        navigationController.popToRootViewController(animated: true)
    }
    
    // MARK: - Updates the views to the next ModelExam
    func updateCurrentViewController(to nextModelExam: ExamModel, data: String?) {
        
        handleData(currentExam: currentModelExam.exam, data: data)
       
        modelManager.currentModel = nextModelExam
        guard let topViewController = navigationController.topViewController as? ExamViewController else { return }
        
        topViewController.updateViewsWithNewData()
    }
    
    // MARK: - Decides what to do with the data
    func handleData(currentExam: Exam, data: String?) {
        guard let data = data else { return }
        let firebaseHandler = FirebaseHandler()
        if let currentResume = navigationController.currentResume {
            firebaseHandler.handleData(resume: currentResume, exam: currentExam, data: data)
        } else {
            let resume = ResumeData()
            resume.resumeName = data
            navigationController.currentResume = resume
            firebaseHandler.handleData(resume: resume, exam: currentExam, data: data)
        }
    }
}

private extension TransitionHandler {
   
    func getViewController(for type: VCType) -> UIViewController {
        switch type {
        case .informationInput:
            return InformationVC()
        case .descriptionInput:
            return DescriptionVC()
        case .main:
            return MainVC()
        case .examEnded:
            return ExamEndedVC()
        }
    }
    
    // MARK: - Should transition
    // TODO: change condition of statement
    func shouldTransition(type: VCType) -> Bool {
        return currentModelExam.type != type
    }
    
    // MARK: - When the resume created by the user has been completed
    func isDoneCreatingResume() -> Bool {
        
        if let lastFoundElement = modelManager.lastFoundElementOfModel() {
            if modelManager.modelAfter(model: lastFoundElement) == nil {
                return false
            }
        }
        
        return modelManager.modelAfter(model: currentModelExam) == nil
    }
    
    func getParentModelManager(modelExam: ExamModel) -> ModelManager<ExamModel>? {
        for model in modelManager.models! {
            if model == modelExam {
                return modelManager
            }
            if let childManager = model.subModelManager {
                for childModel in childManager.models! {
                    if childModel == modelExam {
                        return childManager
                    }
                }
            }
        }
        return nil
    }
 
}
