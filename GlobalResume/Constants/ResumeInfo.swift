//
//  ResumeInfo.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/7/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

enum ResumeInfo: String {
    case contact = "CONTACT INFO"
    case employment = "EMPLOYMENT INFO"
    case education = "EDUCATION INFO"
    case standard = ""
     
//    static func getOptions(info: ResumeInfo) -> [String?] {
////        if let resume = {
//            switch info {
//            case .contact:
//                return [resume.name, resume.gender, resume.email, resume.phone_number, resume.zip_code, resume.profile_description]
//            case .employment:
//
//                let eList = resume.employment?.allObjects as! [Employment]
//                if eList.isEmpty {
//                    return []
//                }
//                var companies: [String?] = Array<String?>(repeating: " ", count: eList.count)
//                for i in 0 ..< eList.count {
//
//                    companies[i] = eList[i].company_name
//                }
//                return companies
//
//            case .education:
//                let eList = resume.education?.allObjects as! [Education]
//                if eList.isEmpty {
//                    return []
//                }
//                var schoolNames: [String?] = Array<String?>(repeating: " ", count: eList.count)
//                for i in 0 ..< eList.count {
//
//                    schoolNames[i] = eList[i].school_name
//                }
//                return schoolNames
//
//            case .standard:
//                let list: [String?] = ["CONTACT INFO", "EMPLOYMENT INFO", "EDUCATION INFO"]
//                return list
//            }
//
////        }
//        return []
//    }
}
