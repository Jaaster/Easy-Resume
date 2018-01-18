//
//  Constants.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

enum Color {
    case blue, grey, green, pink, clear
    
    func getUIColor() -> UIColor {
        let x = CGFloat(255)
        let a = CGFloat(1.0)
        
        switch self {
        case .blue:
            return UIColor(red: 74/x, green: 144/x, blue: 226/x, alpha: a)
        case .grey:
            let g = 155/x
            return UIColor(red: g, green: g, blue: g, alpha: a)
        case .green:
            return UIColor(red: 74/x, green: 226/x, blue: 137/x, alpha: a)
        case .pink:
            return UIColor(red: 249/x, green: 133/x, blue: 238/x, alpha: a)
        case .clear:
            return UIColor.clear
        }
    }
}


