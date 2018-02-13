//
//  ResumeData.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import CoreData

final class ResumeDataHandler {
    // MARK: - The only instance of ResumeDataService should only be used from this class
    private let resumeDataService: ResumeDataService = ResumeDataService()
    // MARK: - Current Variables of the application
    // MARK: - current means current object being edited but the user
    private var currentResume: ResumeData?
    private var currentEmployment: Employment?
    private var currentEducation: Education?
    
    // MARK: - list of all ResumeData objects saved to the device
    var resumeList: [ResumeData]? {
        return resumeDataService.getCoreDataResumeList()
    }
    
    func handleData(key: Exam, data: String?) {
        
        // MARK: - Must have a value otherwise there is no reason to update it
        if let currentResume = currentResume {
            guard let data = data else { return }
            
            resumeDataService.updateData(for: currentResume, with: data, for: key)
        } else {
            // MARK: - Does not have a current resume thus we need to create one
            let createdResume = resumeDataService.createResume()
            currentResume = createdResume
        }
    }
    
    // MARK: - Deletes resume if resume is deletable
    func deleteCurrentResume() {
        guard let resume = currentResume else { return }
        resumeDataService.delete(resume: resume)
        currentResume = nil
    }
    
    func isEditing() -> Bool {
        return currentResume != nil
    }
}

extension ResumeDataHandler {
    func employment(from index: Int) -> Employment {
        let eList = currentResume?.employment?.allObjects as! [Employment]
        return eList[index]
    }
    
    func education(from index: Int) -> Education {
        let eList = currentResume?.education?.allObjects as! [Education]
        return eList[index]
    }
}
