//
//  NSObjectExtension.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 3/24/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

extension NSObject {
    
    var className: String {
        return NSStringFromClass(type(of: self))
    }
}
