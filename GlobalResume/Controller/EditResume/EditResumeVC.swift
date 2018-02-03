//
//  EditResumeVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/1/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class EditResumeVC: UIViewController {
    
    var resumeName: String!
    var editOptions: [String?] = []
    private let cellid = "editResumeCell"
    
    let titleView: UITextView = {
        var textView = UITextView()
        textView.textColor = Color.blue.getUIColor()
        textView.font = UIFont.boldSystemFont(ofSize: 32)
        textView.isEditable = false
        textView.textAlignment = .center
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        return button
    }()
    
    let backButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.transportationStyle(title: "BACK", bgcolor: Color.blue.getUIColor())
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
        
        view.addSubview(titleView)
        view.addSubview(collectionView)
        view.addSubview(bottomStackView)
        
        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        titleView.text = resumeName
        titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -20).isActive = true
        collectionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20).isActive = true
        
    }
    
}


extension EditResumeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @objc func backButtonPressed() {
        if !editOptions.elementsEqual(ResumeInfo.getOptions(info: .standard), by: { (first, second) -> Bool in
            if first == second {
                return true
            }
            return false
        }) {
            
            //Is editing info
            openEditor(for: .standard)
            return
        }
        dismiss(animated: true, completion: nil)
      
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedTitle = editOptions[indexPath.row] {
            if let info = ResumeInfo(rawValue: selectedTitle) {
                openEditor(for: info)
            }
        }
    }
    
    func openEditor(for info: ResumeInfo) {
        editOptions = ResumeInfo.getOptions(info: info)
        if info == .standard {
            bottomStackView.removeArrangedSubview(addButton)
            addButton.isHidden = true
            titleView.text = resumeName
        } else if info == .contact {
            bottomStackView.removeArrangedSubview(addButton)
            addButton.isHidden = true
        } else {
            titleView.text = info.rawValue
            bottomStackView.addArrangedSubview(addButton)
            addButton.isHidden = false
        }
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as? EditResumeCell {
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
            var list = [String?]()
            
            for e in eList {
                list.append(e.company_name)
            }
            
            return list
            
        case .education:
            let eList = resume.education?.allObjects as! [Education]
            var educationNames = [String?]()
            for e in eList {
                educationNames.append(e.school_name)
            }
            return educationNames
            
        case .standard:
            let list: [String?] = ["CONTACT INFO", "EMPLOYMENT INFO", "EDUCATION INFO"]
            return list
        }
        
    }
        return []
    }
}

