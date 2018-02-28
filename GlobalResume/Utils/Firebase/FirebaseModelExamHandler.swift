//
//  FirebaseModelExamHandler.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/14/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

class FirebaseModelExamHandler {
    
    private var firebaseService: FIRFirebaseService
    
    init() {
        firebaseService = FIRFirebaseService()
    }
}

extension FirebaseModelExamHandler {
    
    func getModels() -> [ExamModel]? {
        if let values = firebaseService.getData(for: FIRDataReferencePath.models) {
            
        }
        return nil
    }
}
