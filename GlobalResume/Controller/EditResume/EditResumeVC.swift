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
    
    typealias color = UIColor
    var resumeName: String!
    private var editOptions: [String?] = []
    private var contactInfoCategories: [String] = ["name", "gender", "email", "phone number", "zip code", "profile description"]
    private let cellid = "editResumeCell"
    private var isEditingInfo: Bool = false
    private let resumeHandler = ResumeDataHandler.shared
    private let oneInstance = OneInstance.shared
    private let bottomStackView = UIStackView()
    private var currentEditor = ResumeInfo.standard
    
    let titleLabel: UILabel = {
        var label = UILabel()
        let font = UIFont.myFontRegular.withSize(35)
        label.textColor = color.myBlue
        label.font = font
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let addButton: CustomButton = {
        let button = CustomButton(type: .system)
        let font = UIFont.myFontRegular.withSize(30)
        button.transportationStyle(title: "ADD", bgcolor: color.myBlue)
        button.titleLabel?.font = font
        button.addTarget(self, action: #selector(addButtonPressed), for: UIControlEvents.touchDown)
        return button
    }()
    
    let backButton: CustomButton = {
        let button = CustomButton(type: .system)
        let font = UIFont.myFontRegular.withSize(30)
        button.transportationStyle(title: "BACK", bgcolor: color.myBlue)
        button.titleLabel?.font = font
        button.addTarget(self, action: #selector(backButtonPressed), for: UIControlEvents.touchDown)
        return button
    }()
    
    lazy var whenEditingView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = .white
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EditResumeCell.self, forCellWithReuseIdentifier: cellid)
        
        editOptions = ResumeInfo.getOptions(info: .standard)
        updateViews()
    }
    
    private func updateViews() {
        view.backgroundColor = .white
        
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
        collectionView.reloadData()
    }
}

extension EditResumeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @objc func backButtonPressed() {
        if isEditingInfo {
            openEditor(for: .standard)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func addButtonPressed() {
        if let info = ResumeInfo(rawValue: titleLabel.text!) {
            isEditingInfo = true
            if info == .contact {
                return
            }
            
            if info == .education {
                editData(exam: Exam.schoolName, info: info)
                oneInstance.trigger = Trigger.graduated
                
                let education = Education(context: PersistantService.context)
                resumeHandler.currentEducation = education
            } else if info == .employment {
                editData(exam: Exam.companyName, info: info)
                
                oneInstance.trigger = Trigger.employed
                let employment = Employment(context: PersistantService.context)
                resumeHandler.currentEmployment = employment
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isEditingInfo {
            isEditingInfo = false
            openEditor(for: currentEditor)
            whenEditingView.fade(alpha: 0.0, completion: {
              self.whenEditingView.removeFromSuperview()
              self.whenEditingView.alpha = 1.0
            })
        }
    }
    
    private func editData(exam: Exam, info: ResumeInfo) {
        isEditingInfo = true
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: exam.kind().rawValue)
        currentEditor = info
        if let loadableVC = vc as? LoadableVC {
            loadableVC.currentExam = exam
            view.addSubview(whenEditingView)
            present(vc, animated: true)
            loadableVC.updateData()
        }
    }

    func openEditor(for info: ResumeInfo) {
        currentEditor = info
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
    
    private func handleEditingData(indexPath: IndexPath) {
        
        if let resumeInfo = ResumeInfo(rawValue: titleLabel.text!) {
            
            switch resumeInfo {
                
            case .contact:
                switch indexPath.row {
                case 0:
                    editData(exam: Exam.name, info: resumeInfo)
                case 1:
                    editData(exam: Exam.gender, info: resumeInfo)
                case 2:
                    editData(exam: Exam.email, info: resumeInfo)
                case 3:
                    editData(exam: Exam.number, info: resumeInfo)
                case 4:
                    editData(exam: Exam.zipcode, info: resumeInfo)
                case 5:
                    editData(exam: Exam.profileDescription, info: resumeInfo)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedTitle = editOptions[indexPath.row]{
            if !selectedTitle.isEmpty {
                if let resumeInfo = ResumeInfo(rawValue: selectedTitle) {
                    openEditor(for: resumeInfo)
                    return
                }
            }
        }
        handleEditingData(indexPath: indexPath)
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
            
            cell.titleLabel.text = editOptions[indexPath.row]
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
