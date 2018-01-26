//
//  FIRFirebaseService.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/25/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation
import Firebase

class FIRFirebaseService {
    
    static let shared = FIRFirebaseService()
    private init() {}
    
    func updateExamples(for reference: FIRCollectionReference, for children: Children) {
        let ref = getReference(for: reference, for: children)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String] {
                for v in value {
                    OneInstance.shared.exampleJobList.insert(v)
                }
            }
            
        })
    }

    
    private func getReference(for reference : FIRCollectionReference, for children: Children) -> DatabaseReference {
        return Database.database().reference(withPath: reference.rawValue).child(children.rawValue)
    }
    
    func configure() {
        FirebaseApp.configure()
    }
}
