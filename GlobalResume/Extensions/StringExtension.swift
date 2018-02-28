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
    func myAttributedString(color: UIColor, font: UIFont) -> NSMutableAttributedString {
        let attributes = NSMutableAttributedString(string: self, attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.font : font])
        return attributes
    }
}
