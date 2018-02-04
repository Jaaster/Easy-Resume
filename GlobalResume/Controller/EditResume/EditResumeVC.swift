//
//  EditResumeVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/1/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import Foundation
class EditResumeVC: UIViewController {
    
    var resumeName: String!
    var editOptions: [String?] = []
    var contactInfoCategories: [String] = ["name", "gender", "email", "phone number", "zip code"]
    private let cellid = "editResumeCell"
    
    let titleLabel: UILabel = {
        
        var label = UILabel()
        label.textColor = Color.blue.getUIColor()
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-Regular"))
        label.font = font.withSize(35)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let addButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.transportationStyle(title: "ADD", bgcolor: Color.green.getUIColor())
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-Regular"))
        button.titleLabel?.font = font.withSize(30)
        button.addTarget(self, action: #selector(addButtonPressed), for: UIControlEvents.touchDown)
        return button
    }()
    
    let backButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.transportationStyle(title: "BACK", bgcolor: Color.blue.getUIColor())
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-Regular"))
        button.titleLabel?.font = font.withSize(30)
        button.addTarget(self, action: #selector(backButtonPressed), for: UIControlEvents.touchDown)
        return button
    }()
    
    let bottomStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EditResumeCell.self, forCellWithReuseIdentifier: cellid)
        view.backgroundColor = .white
        editOptions = ResumeInfo.getOptions(info: .standard)
        updateViews()
        collectionView.reloadData()
 
        
    }
    
  
    
    private func updateViews() {
        bottomStackView.addArrangedSubview(backButton)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 20
        
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(bottomStackView)
        
        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        titleLabel.text = resumeName
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -20).isActive = true
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        
    }
    
}


extension EditResumeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @objc func backButtonPressed() {
        if titleLabel.text == resumeName {
            dismiss(animated: true, completion: nil)
        } else {
            //Is editing info
            openEditor(for: .standard)
            return
        }
    }
    
    @objc func addButtonPressed() {
        if let info = ResumeInfo(rawValue: titleLabel.text!) {
            if info == .contact {
                return
            }
            
            if info == .education {
                editData(exam: Exam.schoolName, info: info)
                let handler = ResumeDataHandler.shared
                
                OneInstance.shared.trigger = Trigger.graduated
                let education = Education(context: PersistantService.context)
                handler.currentEducation = education
                
            } else if info == .employment {
                editData(exam: Exam.companyName, info: info)
                let handler = ResumeDataHandler.shared
                
                OneInstance.shared.trigger = Trigger.employed
                let employment = Employment(context: PersistantService.context)
                handler.currentEmployment = employment
            }
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedTitle = editOptions[indexPath.row] {
            if let info = ResumeInfo(rawValue: selectedTitle) {
                openEditor(for: info)
                return
            }
        }
        
        
        if let resumeInfo = ResumeInfo(rawValue: titleLabel.text!) {
            
            switch resumeInfo {
                
            case .contact:
                switch indexPath.row {
                    case 0:
                        //Name
                    editData(exam: Exam.name, info: resumeInfo)
                    case 1:
                        //Gender
                        editData(exam: Exam.gender, info: resumeInfo)
                    case 2:
                        //Email
                        editData(exam: Exam.email, info: resumeInfo)
                    case 3:
                        editData(exam: Exam.number, info: resumeInfo)
                        //Phone Number
                    case 4:
                        editData(exam: Exam.zipcode, info: resumeInfo)
                        //Zipcode
                default:
                    openEditor(for: .contact)
                }
            case .employment:
                editData(exam: Exam.companyName, info: resumeInfo)
                let handler = ResumeDataHandler.shared

                OneInstance.shared.trigger = Trigger.employed
                let employment = handler.employment(from: indexPath.row)
                handler.currentEmployment = employment
                
                return
            case .education:
                editData(exam: Exam.schoolName, info: resumeInfo)
                OneInstance.shared.trigger = Trigger.graduated
              
                let handler = ResumeDataHandler.shared
                let education = handler.education(from: indexPath.row)
                handler.currentEducation = education

                return
            case .standard:
                return
            }
        }
    }
    
    private func editData(exam: Exam, info: ResumeInfo) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: exam.kind().rawValue)
       
        if let loadableVC = vc as? LoadableVC {
            loadableVC.presenting = UIViewController()
            loadableVC.currentExam = exam
            
            let newView = UIView(frame: view.frame)
            newView.backgroundColor = .white
            view.addSubview(newView)
            
            present(vc, animated: true, completion: {
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (time) in
                    if info == ResumeInfo.contact {
                        if self.viewIfLoaded?.window != nil {
                            self.openEditor(for: info)
                            newView.removeFromSuperview()
                            time.invalidate()
                        }
                    } else if OneInstance.shared.trigger == nil {
                        //Trigger is over
                        self.openEditor(for: info)
                        newView.removeFromSuperview()
                        time.invalidate()
                    }
                })
            })
            loadableVC.updateData()
        }
    }


    func openEditor(for info: ResumeInfo) {
        editOptions = ResumeInfo.getOptions(info: info)
        collectionView.reloadData()
        
        if info == .standard {
            bottomStackView.removeArrangedSubview(addButton)
            addButton.isHidden = true
            titleLabel.text = resumeName
        } else if info == .contact {
            bottomStackView.removeArrangedSubview(addButton)
            addButton.isHidden = true
            titleLabel.text = info.rawValue
        } else {
            titleLabel.text = info.rawValue
            bottomStackView.addArrangedSubview(addButton)
            addButton.isHidden = false
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as? EditResumeCell {
            if let info = ResumeInfo(rawValue: titleLabel.text!) {
                switch info {
                case .contact:
                    cell.descriptingView.text = contactInfoCategories[indexPath.row]
                case .employment:
                    cell.descriptingView.text = "company"
                case .education:
                    cell.descriptingView.text = "school"
                case .standard:
                    cell.descriptingView.text = " "
                }
            } else {
                cell.descriptingView.text = " "
            }
            
            cell.titleView.text = editOptions[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editOptions.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

enum ResumeInfo: String {
    case contact = "CONTACT INFO"
    case employment = "EMPLOYMENT INFO"
    case education = "EDUCATION INFO"
    case standard = ""
    
    
    static func getOptions(info: ResumeInfo) -> [String?] {
        if let resume = ResumeDataHandler.shared.currentResume {
        switch info {
        case .contact:
            return [resume.name, resume.gender, resume.email, resume.phone_number, resume.zip_code]
        case .employment:
           
            let eList = resume.employment?.allObjects as! [Employment]
            if eList.isEmpty {
                return []
            }
            var companies: [String?] = Array<String?>(repeating: " ", count: eList.count)
            for i in 0 ..< eList.count {
                
                companies[i] = eList[i].company_name
            }
            return companies
            
        case .education:
            let eList = resume.education?.allObjects as! [Education]
            if eList.isEmpty {
                return []
            }
            var schoolNames: [String?] = Array<String?>(repeating: " ", count: eList.count)
            for i in 0 ..< eList.count {
                
                schoolNames[i] = eList[i].school_name
            }
            return schoolNames
            
        case .standard:
            let list: [String?] = ["CONTACT INFO", "EMPLOYMENT INFO", "EDUCATION INFO"]
            return list
        }
        
    }
        return []
    }
}



