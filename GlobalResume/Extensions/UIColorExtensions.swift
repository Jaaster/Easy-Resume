//
//  UIColorExtensions.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/7/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

extension UIColor {
    static let myBlue = getUIColor(color: "blue")
    static let myRed = getUIColor(color: "red")
    static let myGrey = getUIColor(color: "grey")
    static let myGreen = getUIColor(color: "green")
    static let myPink = getUIColor(color: "pink")
}

func getUIColor(color: String) -> UIColor {
    let x = CGFloat(255)
    let a = CGFloat(1.0)
    
    switch color {
    case "blue":
        return UIColor(red: 74/x, green: 144/x, blue: 226/x, alpha: a)
    case "grey":
        let g = 155/x
        return UIColor(red: g, green: g, blue: g, alpha: a)
    case "green":
        return UIColor(red: 74/x, green: 226/x, blue: 137/x, alpha: a)
    case "pink":
        return UIColor(red: 249/x, green: 133/x, blue: 238/x, alpha: a)
    case "red":
        return UIColor(red: 226/x, green: 74/x, blue: 74/x, alpha: a)
    default:
         return UIColor()
    }
}
