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
        let date = ExamModel(exam: .educationRecord, type: .informationInput, buttonModels: [ButtonModel(title: "START", color: .black), ButtonModel(title: "END", color: .black)])
        let name = ExamModel(exam: .name, type: .informationInput)
        let gender = ExamModel(exam: .gender, type: .informationInput, buttonModels: [ButtonModel(title: "MALE", color: .myBlue), ButtonModel(title: "FEMALE", color: .myPink)])
        let email = ExamModel(exam: .email, type: .informationInput)
        let phoneNumber = ExamModel(exam: .phoneNumber, type: .informationInput)
        let employmentStatus = ExamModel(exam: .employmentStatus, type: .informationInput, buttonModels: [ButtonModel(title: "EMPLOYED", color: .darkGray), ButtonModel(title: "UNEMPLOYED", color: .darkGray), ButtonModel(title: "NO HISTORY", color: .darkGray)])
        let educationStatus = ExamModel(exam: .educationStatus, type: .informationInput, buttonModels: [ButtonModel(title: "YES", color: .darkGray), ButtonModel(title: "NO", color: .darkGray)], descriptions: nil)
        employmentStatus.subModelManager = employmentStatusChildModelManager()
        educationStatus.subModelManager = educationStatusChildModelManager()
        let profileDescrition = ExamModel(exam: .profileDescription, type: .descriptionInput, buttonModels: nil, descriptions: ["I am awesome", "I am funny", "I am Dwight Schrute"])
        let zipcode = ExamModel(exam: .zipcode, type: .informationInput)
        topModelManager.models = [menu, date, resumeName, name, gender, phoneNumber, zipcode, educationStatus, employmentStatus, email, profileDescrition]
        return topModelManager
    }
    
    
    private func educationStatusChildModelManager() -> ModelManager<ExamModel> {
        let modelManager = ModelManager<ExamModel>()
        
        let schoolName = ExamModel(exam: .schoolName, type: .informationInput)
        let educationLevel = ExamModel(exam: .educationLevel, type: .informationInput)
        let fieldOfStudy = ExamModel(exam: .fieldOfStudy, type: .informationInput)
        let educationRecord = ExamModel(exam: .educationRecord, type: .informationInput, buttonModels: [ButtonModel(title: "START", color: .black), ButtonModel(title: "END", color: .black)])
        let educationDescription = ExamModel(exam: .educationDescription, type: .descriptionInput, buttonModels: [], descriptions: ["Just another fun description that is hard coded :P", "GOSH I really need to make this editable from the database...ohhh well"])
        modelManager.models = [schoolName, educationLevel, fieldOfStudy, educationRecord, educationDescription]
        return modelManager
    }
    
    
    private func employmentStatusChildModelManager() -> ModelManager<ExamModel> {
        let modelMananger = ModelManager<ExamModel>()
        
        let companyName = ExamModel(exam: .companyName, type: .informationInput)
        let jobTitle = ExamModel(exam: .jobTitle, type: .informationInput)
        let jobDescription = ExamModel(exam: .jobDescription, type: .descriptionInput, buttonModels: nil, descriptions: ["Some description", "Another drawn out description for no reason lol!"])
        let employmentRecord = ExamModel(exam: .employmentRecord, type: .informationInput, buttonModels: [ButtonModel(title: "START", color: .darkGray), ButtonModel(title: "END", color: .darkGray)])
        
        modelMananger.models = [companyName, jobTitle, employmentRecord, jobDescription]
        return modelMananger
    }
    
}
