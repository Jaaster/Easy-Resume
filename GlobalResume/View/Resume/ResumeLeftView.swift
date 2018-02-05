//
//  ResumeLeftView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/4/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class ResumeLeftView: UIView {
    
    var resume: ResumeData! {
        willSet {
            resume = newValue
            loadData()
            setupViews()
        }
    }
    
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Joriah Lasater"
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-ExtraBold"))
        label.font = font.withSize(30)
        label.sizeToFit()
        label.textColor = Color.red.getUIColor()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   lazy var profileDescription: UILabel = {
        
        let label = UILabel()
        label.text = "e.g A self-motived and orginized professional with over 10 years of experience in software engineering and AI technologies"
        label.textColor = Color.blue.getUIColor()
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-Regular"))
        label.font = font.withSize(15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
        
    }()
    
    
    let employmentSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Employment History:"
        label.textColor = Color.red.getUIColor()
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-Regular"))
        label.font = font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let educationSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Education History:"
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-Regular"))
        label.font = font.withSize(20)
        label.textColor = Color.red.getUIColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var employmentViews: [HistoryView]!
    var educationViews: [HistoryView]!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userName)
        addSubview(employmentSectionLabel)
        addSubview(educationSectionLabel)
        addSubview(profileDescription)
        educationViews = []
        employmentViews = []
    }
    
    func loadData() {
        userName.text = resume.name
        profileDescription.text = resume.profile_description

        var eList = resume.employment?.allObjects as! [Employment]
        
        if eList.isEmpty {
            employmentViews = []
        }
        
        for i in 0 ..< eList.count {
            let hView = HistoryView()
            hView.place.text = eList[i].company_name
            hView.startAndEndDate.text = eList[i].employment_record
            hView.position.text = eList[i].job_title
            hView.myDescription.text = eList[i].job_description
            employmentViews.append(hView)
        }
        
        var eList1 = resume.education?.allObjects as! [Education]

        if eList1.isEmpty {
            educationViews = []
        }
        
        for i in 0 ..< eList1.count {
            let hView = HistoryView()
            hView.place.text = eList1[i].school_name
            hView.startAndEndDate.text = eList1[i].education_record
            hView.position.text = "\(eList1[i].education_level!) in \(eList1[i].field_of_study!)"
            hView.myDescription.text = eList1[i].education_description
            educationViews.append(hView)
        }
    }
    
    
    func setupEmploymentViews() {
        
        var previousE: UIView = employmentSectionLabel
        for e in employmentViews {
            
            e.translatesAutoresizingMaskIntoConstraints = false
            e.backgroundColor = .white
            addSubview(e)
            
            e.topAnchor.constraint(equalTo: previousE.bottomAnchor).isActive = true
            e.leadingAnchor.constraint(equalTo:  previousE.leadingAnchor).isActive = true
            e.trailingAnchor.constraint(equalTo: previousE.trailingAnchor).isActive = true
            previousE = e
        }
        
    }
    
    
    func setupEducationViews() {
        
        var previousE: UIView = educationSectionLabel
        for e in educationViews {
            
            e.translatesAutoresizingMaskIntoConstraints = false
            e.backgroundColor = .white
            addSubview(e)
            
            e.topAnchor.constraint(equalTo: previousE.bottomAnchor).isActive = true
            e.leadingAnchor.constraint(equalTo:  previousE.leadingAnchor).isActive = true
            e.trailingAnchor.constraint(equalTo: previousE.trailingAnchor).isActive = true
            previousE = e
        }
        
    }
    
    func setupViews() {
        
        heightAnchor.constraint(equalToConstant: CGFloat(employmentViews.count + educationViews.count) * 200 + 320).isActive = true
        
        
        userName.topAnchor.constraint(equalTo: topAnchor).isActive = true
        userName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        userName.heightAnchor.constraint(equalToConstant: userName.frame.height).isActive = true
        
        profileDescription.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10).isActive = true
        profileDescription.leadingAnchor.constraint(equalTo: userName.leadingAnchor).isActive = true
        profileDescription.trailingAnchor.constraint(equalTo: userName.trailingAnchor).isActive = true
 
        
        
        employmentSectionLabel.topAnchor.constraint(equalTo: profileDescription.bottomAnchor).isActive = true
        employmentSectionLabel.leadingAnchor.constraint(equalTo: profileDescription.leadingAnchor).isActive = true
        employmentSectionLabel.trailingAnchor.constraint(equalTo: profileDescription.trailingAnchor).isActive = true
        employmentSectionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        setupEmploymentViews()
        if let last = employmentViews.last {
            educationSectionLabel.topAnchor.constraint(equalTo: last.bottomAnchor).isActive = true
        } else {
            educationSectionLabel.topAnchor.constraint(equalTo: employmentSectionLabel.bottomAnchor).isActive = true

        }
        educationSectionLabel.leadingAnchor.constraint(equalTo: profileDescription.leadingAnchor).isActive = true
        educationSectionLabel.trailingAnchor.constraint(equalTo: profileDescription.trailingAnchor).isActive = true
        educationSectionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        setupEducationViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

