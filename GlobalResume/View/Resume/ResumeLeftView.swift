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
        label.font = label.font.withSize(25)
        label.textColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    let userDescription: UILabel = {
        
        let label = UILabel()
        label.text = "e.g A self-motived and orginized professional with over 10 years of experience in software engineering and AI technologies"
        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        
        return label
        
    }()
    
    
    let employmentSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Employment History"
        label.textColor = .red
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let educationSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Education History"
        label.textColor = .red
        label.backgroundColor = .black
        
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
        addSubview(userDescription)
        educationViews = [HistoryView(), HistoryView()]
        employmentViews = []
    }
    
    func loadData() {
        userName.text = resume.resume_name
        
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
            hView.position.text = eList1[i].education_level
            hView.myDescription.text = eList1[i].field_of_study
            employmentViews.append(hView)
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
            e.heightAnchor.constraint(equalToConstant: 200).isActive = true
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
            e.heightAnchor.constraint(equalToConstant: 200).isActive = true
            previousE = e
        }
        
    }
    
    func setupViews() {
        
        heightAnchor.constraint(equalToConstant: CGFloat(employmentViews.count + educationViews.count) * 200 + 320).isActive = true
        
        
        userName.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        userName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        userDescription.topAnchor.constraint(equalTo: userName.bottomAnchor).isActive = true
        userDescription.leadingAnchor.constraint(equalTo: userName.leadingAnchor).isActive = true
        userDescription.trailingAnchor.constraint(equalTo: userName.trailingAnchor).isActive = true
        userDescription.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        employmentSectionLabel.topAnchor.constraint(equalTo: userDescription.bottomAnchor).isActive = true
        employmentSectionLabel.leadingAnchor.constraint(equalTo: userDescription.leadingAnchor).isActive = true
        employmentSectionLabel.trailingAnchor.constraint(equalTo: userDescription.trailingAnchor).isActive = true
        employmentSectionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        setupEmploymentViews()
        
        educationSectionLabel.topAnchor.constraint(equalTo: employmentViews.last!.bottomAnchor).isActive = true
        educationSectionLabel.leadingAnchor.constraint(equalTo: userDescription.leadingAnchor).isActive = true
        educationSectionLabel.trailingAnchor.constraint(equalTo: userDescription.trailingAnchor).isActive = true
        educationSectionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        setupEducationViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

