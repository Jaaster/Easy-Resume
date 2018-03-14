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
    
    func getData(for path: FIRDataReferencePath) -> Any? {
        let reference = resumeReference(uid: "", resume: "")
        var value: Any?
        
        reference.observeSingleEvent(of: .value) { (snapshot) in
            value = snapshot.value
        }
        return value
    }
    
    func listenToUsersResumeData() {
        let reference = userReference().child(FIRDataReferencePath.resumes.rawValue)
        let resumeModelHandler = ResumeModelHandler()
        reference.observe( .value) { (snapshot) in
            if let value = snapshot.value as? [String : AnyObject] {
                resumeModelHandler.updateModelsFromDataBase(data: value)
            }
        }
    }
    
    
    func updateData(forResume: String, value: Exam, with data: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = resumeReference(uid: uid, resume: forResume)
        
        ref.updateChildValues([value.configureToVariableName() : data]) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    } 
    
    func updateData(forResume: String, employment: String, value: Exam, with data: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = resumeReference(uid: uid, resume: forResume).child(FIRDataReferencePath.employment.rawValue).child(employment)
        
        ref.updateChildValues([value.configureToVariableName() : data]) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateData(forResume: String, education: String, value: Exam, with data: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = resumeReference(uid: uid, resume: forResume).child(FIRDataReferencePath.education.rawValue).child(education)
        
        ref.updateChildValues([value.configureToVariableName() : data]) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

private extension FIRFirebaseService {

    func resumeReference(uid: String, resume: String) -> DatabaseReference {
        return userReference().child(FIRDataReferencePath.resumes.rawValue).child(resume)
    }
    
    func userReference() -> DatabaseReference {
        return Database.database().reference().child(FIRDataReferencePath.users.rawValue).child(uid ?? "Nil User")
    }
}
