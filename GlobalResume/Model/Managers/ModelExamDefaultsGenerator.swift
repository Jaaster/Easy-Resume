//
//  ModelExamDefaultsGenerator.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/26/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

struct ModelExamDefaultsGenerator {
    
    func generateTestModelManagerWithModels() -> ModelManager<ExamModel> {
        let topModelManager = ModelManager<ExamModel>()

        let model = ExamModel(exam: .jobDescription, type: .informationInput)
        
        topModelManager.models = [model]
        return topModelManager
    }
    
    func generateDefaultModelManagerWithModels() -> ModelManager<ExamModel> {
        let topModelManager = ModelManager<ExamModel>()
        let menu = ExamModel(exam: .menu, type: .main)
        let resumeName = ExamModel(exam: .resumeName, type: .informationInput)
        let date = ExamModel(exam: .educationRecord, type: .informationInput, buttonModels: [ButtomModel(title: "START", color: .black), ButtomModel(title: "END", color: .black)])
        let name = ExamModel(exam: .name, type: .informationInput)
        let gender = ExamModel(exam: .gender, type: .informationInput, buttonModels: [ButtomModel(title: "MALE", color: .myBlue), ButtomModel(title: "FEMALE", color: .myPink)])
        let email = ExamModel(exam: .email, type: .informationInput)
        let phoneNumber = ExamModel(exam: .phoneNumber, type: .informationInput)
        let employmentStatus = ExamModel(exam: .employmentStatus, type: .informationInput, buttonModels: [ButtomModel(title: "EMPLOYED", color: .darkGray), ButtomModel(title: "UNEMPLOYED", color: .darkGray), ButtomModel(title: "NO HISTORY", color: .darkGray)])
        employmentStatus.subModelManager = employmentStatusChildModelManager()
        
        topModelManager.models = [menu, date, resumeName, name, gender, phoneNumber, employmentStatus, email]
        return topModelManager
    }
    
    
    private func employmentStatusChildModelManager() -> ModelManager<ExamModel> {
        let employmentStatusChildModelManager = ModelManager<ExamModel>()
        
        let companyName = ExamModel(exam: .companyName, type: .informationInput)
        let jobTitle = ExamModel(exam: .jobTitle, type: .informationInput)
        let jobDescription = ExamModel(exam: .jobDescription, type: .descriptionInput, buttonModels: nil, descriptions: ["Some description", "Another drawn out description for no reason lol!"])
        let employmentRecord = ExamModel(exam: .employmentRecord, type: .informationInput, buttonModels: [ButtomModel(title: "START", color: .darkGray), ButtomModel(title: "END", color: .darkGray)])
        
        employmentStatusChildModelManager.models = [companyName, jobTitle, employmentRecord, jobDescription]
        return employmentStatusChildModelManager
    }
    
}
