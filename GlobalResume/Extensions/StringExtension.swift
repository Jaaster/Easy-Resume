//
//  StringExtension.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/27/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var camelCase: String? {
        let items = self.components(separatedBy: "_")
        return items[1...].reduce(items[0].lowercased(), { $0 + $1.capitalized })
    }
    
    var snakeCase: String? {
        get {
            let pattern = "([a-z0-9])([A-Z])"
            
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: characters.count)
            return (regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased())     }
    }
    
    var titleCase: String {
        get {
            let pattern = "([A-Z])"
            
            let regex = try? NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: characters.count)
            return (regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: " $1"))!.uppercased()//.replacingOccurrences(of: "_", with: " ")
        }
    }
    
    func myAttributedString(color: UIColor, font: UIFont) -> NSMutableAttributedString {
        let attributes = NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.font : font])
        return attributes
    }
}
