//
//  ModelExamDefaultsGenerator.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/26/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

struct ModelExamDefaultsGenerator {
    
    func generateModelManagerWithModels() -> ModelManager<ExamModel> {
        let topModelManager = ModelManager<ExamModel>()
        // MARK: - ModelManager on the top of the hierachy
        let menu = ExamModel(exam: .menu, type: .main)
        let resumeName = ExamModel(exam: .resumeName, type: .informationInput)
        let name = ExamModel(exam: .name, type: .informationInput)
        let gender = ExamModel(exam: .gender, type: .informationInput, buttonModels: [ButtomModel(title: "MALE", color: .myBlue), ButtomModel(title: "FEMALE", color: .myPink)])
        let email = ExamModel(exam: .email, type: .informationInput)
        
        var employmentStatus = ExamModel(exam: .employmentStatus, type: .informationInput, buttonModels: [ButtomModel(title: "EMPLOYED", color: .darkGray), ButtomModel(title: "UNEMPLOYED", color: .darkGray), ButtomModel(title: "NO HISTORY", color: .darkGray)])
        employmentStatus.subModelManager = employmentStatusChildModelManager()
        
        topModelManager.models = [menu, resumeName, name, gender, employmentStatus, email]
        return topModelManager
    }
    
    
    private func employmentStatusChildModelManager() -> ModelManager<ExamModel> {
        let employmentStatusChildModelManager = ModelManager<ExamModel>()
        
        let companyName = ExamModel(exam: .companyName, type: .informationInput)
        let jobTitle = ExamModel(exam: .jobTitle, type: .informationInput)
        let employmentRecord = ExamModel(exam: .employmentRecord, type: .informationInput, buttonModels: [ButtomModel(title: "START", color: .darkGray), ButtomModel(title: "END", color: .darkGray)])
        
        employmentStatusChildModelManager.models = [companyName, jobTitle, employmentRecord]
        return employmentStatusChildModelManager
    }
    
}
