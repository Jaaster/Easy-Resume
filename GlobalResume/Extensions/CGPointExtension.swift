//
//  CGPointExtension.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 5/1/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
extension CGPoint {
    func add(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    func subtract(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x - x, y: self.y - y)
    }
}
