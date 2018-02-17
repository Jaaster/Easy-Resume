////
////  ResumeLeftView.swift
////  GlobalResume
////
////  Created by Joriah Lasater on 2/4/18.
////  Copyright © 2018 Joriah Lasater. All rights reserved.
////
//
//import UIKit
//
//class ResumeLeftView: UIView {
//    
//    var resume: ResumeData! {
//        didSet {
//            loadData()
//            setupViews()
//        }
//    }
//    
//    private var employmentViews: [HistoryView]!
//    private var educationViews: [HistoryView]!
//    
//    let userName: UILabel = {
//        let label = UILabel()
//        let font = UIFont.myFontRegular.withSize(25)
//        label.font = font
//        label.sizeToFit()
//        label.textColor = UIColor.myRed
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//   lazy var profileDescription: UILabel = {
//        let label = UILabel()
//        let font = UIFont.myFontRegular.withSize(15)
//        label.textColor = UIColor.myBlue
//        label.font = font
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.lineBreakMode = .byWordWrapping
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    let employmentSectionLabel: UILabel = {
//        let label = UILabel()
//        let font = UIFont.myFontRegular.withSize(20)
//        label.textColor = UIColor.myRed
//        label.font = font
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    let educationSectionLabel: UILabel = {
//        let label = UILabel()
//        let font = UIFont.myFontRegular.withSize(20)
//        label.font = font
//        label.textColor = UIColor.myRed
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        addSubview(userName)
//        addSubview(employmentSectionLabel)
//        addSubview(educationSectionLabel)
//        addSubview(profileDescription)
//        educationViews = []
//        employmentViews = []
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func loadData() {
//        userName.text = resume.name
//        profileDescription.text = resume.profile_description
//
//        var employmentList = resume.employment?.allObjects as! [Employment]
//        
//        if employmentList.isEmpty {
//            employmentViews = []
//        }
//        
//        for i in 0 ..< employmentList.count {
//            let hView = HistoryView()
//            hView.place.text = employmentList[i].company_name
//            hView.startAndEndDate.text = employmentList[i].employment_record
//            hView.position.text = employmentList[i].job_title
//            hView.myDescription.text = employmentList[i].job_description
//            employmentViews.append(hView)
//        }
//        
//        var educationList = resume.education?.allObjects as! [Education]
//
//        if educationList.isEmpty {
//            educationViews = []
//        }
//        
//        for i in 0 ..< educationList.count {
//            let hView = HistoryView()
//            hView.place.text = educationList[i].school_name
//            hView.startAndEndDate.text = educationList[i].education_record
//            hView.position.text = "\(educationList[i].education_level!) in \(educationList[i].field_of_study!)"
//            hView.myDescription.text = educationList[i].education_description
//            educationViews.append(hView)
//        }
//    }
//    
//    func setupViews() {
//        
//        heightAnchor.constraint(equalToConstant: CGFloat(employmentViews.count + educationViews.count) * 200 + 320).isActive = true
//        
//        
//        userName.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        userName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
//        userName.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        
//        profileDescription.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10).isActive = true
//        profileDescription.leadingAnchor.constraint(equalTo: userName.leadingAnchor).isActive = true
//        profileDescription.trailingAnchor.constraint(equalTo: userName.trailingAnchor).isActive = true
//        
//        
//        
//        employmentSectionLabel.topAnchor.constraint(equalTo: profileDescription.bottomAnchor).isActive = true
//        employmentSectionLabel.leadingAnchor.constraint(equalTo: profileDescription.leadingAnchor).isActive = true
//        employmentSectionLabel.trailingAnchor.constraint(equalTo: profileDescription.trailingAnchor).isActive = true
//        employmentSectionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        
//        setupEmploymentViews()
//        if let last = employmentViews.last {
//            educationSectionLabel.topAnchor.constraint(equalTo: last.bottomAnchor).isActive = true
//        } else {
//            educationSectionLabel.topAnchor.constraint(equalTo: employmentSectionLabel.bottomAnchor).isActive = true
//            
//        }
//        educationSectionLabel.leadingAnchor.constraint(equalTo: profileDescription.leadingAnchor).isActive = true
//        educationSectionLabel.trailingAnchor.constraint(equalTo: profileDescription.trailingAnchor).isActive = true
//        educationSectionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        
//        setupEducationViews()
//        
//    }
//    
//    func setupEmploymentViews() {
//        var previousE: UIView = employmentSectionLabel
//        for e in employmentViews {
//            e.translatesAutoresizingMaskIntoConstraints = false
//            e.backgroundColor = .white
//            addSubview(e)
//            
//            e.topAnchor.constraint(equalTo: previousE.bottomAnchor).isActive = true
//            e.leadingAnchor.constraint(equalTo:  previousE.leadingAnchor).isActive = true
//            e.trailingAnchor.constraint(equalTo: previousE.trailingAnchor).isActive = true
//            previousE = e
//        }
//    }
//    
//    func setupEducationViews() {
//        
//        var previousE: UIView = educationSectionLabel
//        for e in educationViews {
//            
//            e.translatesAutoresizingMaskIntoConstraints = false
//            e.backgroundColor = .white
//            addSubview(e)
//            
//            e.topAnchor.constraint(equalTo: previousE.bottomAnchor).isActive = true
//            e.leadingAnchor.constraint(equalTo:  previousE.leadingAnchor).isActive = true
//            e.trailingAnchor.constraint(equalTo: previousE.trailingAnchor).isActive = true
//            previousE = e
//        }
//    }
//}

