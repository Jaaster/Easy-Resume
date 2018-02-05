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
    
    func configure() {
        FirebaseApp.configure()
        DispatchQueue.global(qos: .userInteractive).async {
            self.updateData(for: .examples, with: .jobs)
            self.updateData(for: .examples, with: .education)
            self.updateData(for: .examples, with: .profile)
        }
    }
    
    private func updateData(for parent: FIRCollectionReferenceParent, with child: FIRCollectionReferenceParent.Child) {
        let ref = getReference(for: parent, with: child)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String] {
                for v in value {
                    if child == .jobs {
                        OneInstance.shared.exampleJobList.insert(v)
                    } else if child == .education {
                        OneInstance.shared.exampleEducationDescriptionList.insert(v)
                    } else if child == .profile {
                        OneInstance.shared.exampleProfileDescriptionList.insert(v)
                    }
                }
            }
            
        })
    }

    
    private func getReference(for reference: FIRCollectionReferenceParent, with child: FIRCollectionReferenceParent.Child) -> DatabaseReference {
        return Database.database().reference(withPath: reference.rawValue).child(child.rawValue)
    }
    
   
}
