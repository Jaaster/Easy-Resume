//
//  ArrayExtension.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 3/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}
