//
//  FIRFirebaseService.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/25/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Firebase
import FirebaseAuth

class FIRFirebaseService {
    let uid = Auth.auth().currentUser?.uid
}

extension FIRFirebaseService {
    
    func listenForUserResumeDataChange() {
        let reference = userReference().child(FIRDataReferencePath.resumes.rawValue)
        let resumeModelHandler = ResumeModelHandler()
        reference.observe( .value) { (snapshot) in
            if let value = snapshot.value as? [String : AnyObject] {
                resumeModelHandler.updateModelsFromDataBase(data: value)
            }
        }
    }
    
    func updateData(resumeID: String, value: Exam, data: String) {
        
        let ref = resumeReference(resumeID: resumeID)
        ref.updateChildValues([value.configureToVariableName() : data]) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(resumeID: String) {
        let ref = resumeReference(resumeID: resumeID)
        ref.removeValue()
    }
    
    func delete(resumeID: String, employmentID: String) {
        let ref = resumeReference(resumeID: resumeID).child(FIRDataReferencePath.employment.rawValue).child(employmentID)
        ref.removeValue()
    }
    
    func delete(forResume: String, education: String) {
        
    }
    
    func updateEmploymentData(resumeID: String, employmentID: String, value: Exam, data: String) {
        let ref = resumeReference(resumeID: resumeID).child(FIRDataReferencePath.employment.rawValue).child(employmentID)
        
        ref.updateChildValues([value.configureToVariableName() : data]) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateEducationData(resumeID: String, educationID: String, value: Exam, data: String) {
        let ref = resumeReference(resumeID: resumeID).child(FIRDataReferencePath.education.rawValue).child(educationID)
        
        ref.updateChildValues([value.configureToVariableName() : data]) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

private extension FIRFirebaseService {

    func resumeReference(resumeID: String) -> DatabaseReference {
        return userReference().child(FIRDataReferencePath.resumes.rawValue).child(resumeID)
    }
    
    func userReference() -> DatabaseReference {
        return Database.database().reference().child(FIRDataReferencePath.users.rawValue).child(uid ?? "Nil User")
    }
}
