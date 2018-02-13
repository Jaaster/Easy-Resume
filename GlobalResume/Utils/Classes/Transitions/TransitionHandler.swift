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
    
    // MARK: Current ExamModel being displayed in the presented view controller
    private var currentModelExam: ModelExam
    private var examEnded: Bool = false
    // MARK: The current Exam View Controller being displayed on the application
    private var currentExamViewController: ExamViewController
    
    // MARK: A reference to the only ModelManager in the application. No Singleton here :P
    private var modelManager: ModelManager<ModelExam>
    private let resumeDataHandler: ResumeDataHandler
    private let transitionService = TransitionService()
 
    // MARK: Initializing variables
    init(currentExamViewController: ExamViewController) {
        self.currentExamViewController = currentExamViewController
        
        // MARK: - Classes that will be Injected into any newly presented ExamViewControllers
        modelManager = currentExamViewController.modelManager
        resumeDataHandler = currentExamViewController.dataHandler
        
        // MARK: - Checks to see if the current model is equal to nil if so this means that the exams are over
        if let currentModel = modelManager.currentModel {
            currentModelExam = currentModel
        } else {
            // MARK: - There arent any ModelExams left to display
            examEnded = true
            
            // TODO: get rid of this ugly thing
            currentModelExam = ModelExam(exam: Exam.name, type: Type.input, title: "NEVER GOING TO HAPPEN", color: UIColor.red, parentModelExamManager: modelManager)
        }
    }
}

extension TransitionHandler {
    
    // MARK: - Decides if the view controller should present/dismiss or reload views
    func decideCourse(data: String?) {
        
            // MARK: - Has childModelManager, which means we need to start going through its collection of models
        if let childModelManager = currentModelExam.childModelExamManager {
            // MARK: - Start going through the models in the child model manager
            transitionOrUpdate(nextModelExam: childModelManager.models![0], data: data)
            return
        }
        
        // MARK: - This model does not have the same manager
        if currentModelExam.parentModelExamManager !== modelManager {
            let parentModelExamManager = currentModelExam.parentModelExamManager
            if let nextModelExam = parentModelExamManager.modelAfter(model: currentModelExam) {
                transitionOrUpdate(nextModelExam: nextModelExam, data: data)
                return
            } else {
                // MARK: No more models after this currentModelExam
                // MARK: - Going back to the original modelManager and getting the last model we presented to the user
                if let lastFoundElement = modelManager.lastFoundElementOfModel() {
                    currentModelExam = lastFoundElement
                }
            }
        }
        
        if isDoneCreatingResume() {
            // MARK: - Dismiss To the root View Controller is manditory after the user has completed creating the resume
            transitionToRootView()
            // MARK: - Resetsa the current model to the first one, which is the main/menu 
            modelManager.resetCurrentModel()
            return
        }
        
        // MARK: - Has another exam after the current one
        if let nextExamModel = modelManager.modelAfter(model: currentModelExam) {
            // MARK: - If the next exam requires that the view controller change
           transitionOrUpdate(nextModelExam: nextExamModel, data: data)
        }
    }
}

private extension TransitionHandler {
    
    // MARK: - Decides whether presenting a new view controller or updating the current view controller should take place
    func transitionOrUpdate(nextModelExam: ModelExam, data: String?) {
        if shouldTransition(type: nextModelExam.type) {
            transitionTo(nextModelExam: nextModelExam, data: data)
        } else {
            updateCurrentViewController(to: nextModelExam, data: data)
        }
    }
    
    // MARK: - Takes the next model exam to be presented and the data entered by the user for the previous exam. 
    func transitionTo(nextModelExam: ModelExam, data: String?) {
        
        // MARK: Instantiate the Storyboard with all of the View Controllers for this application
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        // MARK: - Initialization of identifier for the appropiate View Controller required to represent the nextModelExam
        let identifier = nextModelExam.type.rawValue
        
        // MARK: - Next View Controller
        let nextViewController = sb.instantiateViewController(withIdentifier: identifier)
        
        // MARK: - If the View Controller to be presented is an ExamViewController(Can present the data from the nextModelExam)
        if var nextExamViewController = nextViewController as? ExamViewController {
            // MARK: - Update the current model to the next one before it is injected
            modelManager.currentModel = nextModelExam
            
            // MARK: - Inject Dependencies like specified in the initializer
            injectDependencies(examViewController: &nextExamViewController)
        }
        
        // MARK: - Handles the actual transition
        transitionService.present(nextViewController: nextViewController, from: currentExamViewController as! UIViewController)
        
        // MARK: - Transfer the data passed in by the user to data management
        if let data = data {
            dataManagement(currentExam: currentModelExam.exam, data: data)
        }
    }
    
    // MARK: - Transition to root view controller
    func transitionToRootView() {
        transitionService.dismissToRootViewController()
    }
    
    // MARK: - Updates the views to the next ModelExam
    func updateCurrentViewController(to nextModelExam: ModelExam, data: String?) {
        
        dataManagement(currentExam: currentModelExam.exam, data: data)
       
        modelManager.currentModel = nextModelExam
        // MARK: - Inject Dependencies like specified in the initializer
        injectDependencies(examViewController: &currentExamViewController)
        currentExamViewController.updateViewsWithNewData()
    }
    
    // MARK: - Sends the Data to the ResumeDataHandler to be further processed
    func dataManagement(currentExam: Exam, data: String?) {
        
        // MARK: - Handler is for deciding where the data should go
        let resumeDataHandler = ResumeDataHandler()
        
        // MARK: - Takes a key which in the CoreData Database is of type Exam and the value which is the data
        resumeDataHandler.handleData(key: currentExam, data: data)
    }
}

private extension TransitionHandler {
    // MARK: - Checks to see if there is a resume being edited by the user
    func isEditingCurrentResume() -> Bool {
        return false
    }
    
    // MARK: - Should transition
    func shouldTransition(type: Type) -> Bool {
        return type != currentModelExam.type
    }
    
    // MARK: - When the resume created by the user has been completed
    func isDoneCreatingResume() -> Bool {
        return modelManager.modelAfter(model: currentModelExam) == nil
    }
    
   
    // MARK: - Injects the dependencies required for the  next view controller to be presented without unwrapped nil values
    func injectDependencies(examViewController: inout ExamViewController) {
        examViewController.dataHandler = resumeDataHandler
        examViewController.modelManager = modelManager
    }
 
}
