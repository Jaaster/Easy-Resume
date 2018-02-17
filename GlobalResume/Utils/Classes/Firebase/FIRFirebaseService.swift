//
//  FIRFirebaseService.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/25/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Firebase
class FIRFirebaseService {
    
    init() {
        configure()
    }
}

extension FIRFirebaseService {
    func getData(for path: FIRDataReferencePath) -> Any? {
        let reference = getReference(with: path)
        var value: Any?
        
        reference.observeSingleEvent(of: .value) { (snapshot) in
            value = snapshot.value
        }
        return value
    }
}

private extension FIRFirebaseService {
    func configure() {
        FirebaseApp.configure()
    }
    
    func getReference(with path: FIRDataReferencePath) -> DatabaseReference {
        return Database.database().reference(withPath: path.rawValue)
    }
}
