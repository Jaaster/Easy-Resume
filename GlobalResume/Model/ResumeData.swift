//
//  ResumeData.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class ResumeData {
    
    static let shared = ResumeData()
    private var data: [Exam : String]

    init() {
        data = [:]
        loadValues()
    }
    
    private func loadValues() {
        for exam in Exam.allValues() {
            data.updateValue("", forKey: exam)
        }
    }
    
    func updateData(dataType: Exam, data: String) {
        self.data.updateValue(data, forKey: dataType)
    }

    func getData(forKey: Exam) -> String {
        return data[forKey]!
    }
}




