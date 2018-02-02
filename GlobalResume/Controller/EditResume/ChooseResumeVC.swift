//
//  ChooseResumeVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/1/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation

import UIKit

private let reuseIdentifier = "resumeCell"

class ChooseResumeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let list = ResumeDataHandler.shared.getResumeList()!
    var currentCellIndex = 0
    
    let editButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.transportationStyle(title: "EDIT", bgcolor: Color.green.getUIColor())
        button.addTarget(self, action: #selector(editButtonPressed), for: UIControlEvents.touchDown)
        return button
    }()
    
    let backButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.transportationStyle(title: "BACK", bgcolor: Color.blue.getUIColor())
        button.addTarget(self, action: #selector(backButtonPressed), for: UIControlEvents.touchDown)
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(ResumeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.isPagingEnabled = true
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
             layout.scrollDirection = .horizontal
        }
        updateLayout()
       
    }
    
    func updateLayout() {
        let bottomStackView = UIStackView(arrangedSubviews: [backButton, editButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 20

        view.addSubview(bottomStackView)
        
        bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentCellIndex = indexPath.item
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ResumeCell {
            cell.resume = list[indexPath.item]
            cell.viewUpdate()
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}

extension ChooseResumeVC {
    
    @objc func backButtonPressed() {
        performSegue(withIdentifier: "MENU", sender: nil)
    }
    
    @objc func editButtonPressed() {
        let editResumeVC = EditResumeVC()
        let resume = list[currentCellIndex]
        editResumeVC.resumeName = resume.resume_name
        ResumeDataHandler.shared.currentResume = resume
        navigationController?.pushViewController(editResumeVC, animated: true)
    }
    
}
