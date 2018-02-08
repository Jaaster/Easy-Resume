//
//  ChooseResumeVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/1/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import Foundation
import UIKit

class ChooseResumeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   typealias color = UIColor
   private var resumeHandler = ResumeDataHandler.shared
    
    var resumes: [ResumeData?] {
        get {
            if let resumes = resumeHandler.getCoreDataResumeList() {
                return resumes
            } else {
                present(forward: false)
                return []
            }
        }
    }
    
    private let reuseIdentifier = "resumeCell"
    private var currentCellIndex = 0
    private let sb = UIStoryboard(name: "Main", bundle: nil)

    let editButton: CustomButton = {
        let button = CustomButton(type: .system)
        let font = UIFont.myFontRegular.withSize(35)
        button.transportationStyle(title: "EDIT", bgcolor: color.myBlue)
        button.addTarget(self, action: #selector(editButtonPressed), for: UIControlEvents.touchDown)
        button.titleLabel?.font = font
        return button
    }()
    
    let backButton: CustomButton = {
        let button = CustomButton(type: .system)
        let font = UIFont.myFontRegular.withSize(35)
        
        button.transportationStyle(title: "BACK", bgcolor: color.myBlue)
        button.titleLabel?.font = font
        button.addTarget(self, action: #selector(backButtonPressed), for: UIControlEvents.touchDown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupViews()
    }
    
    func setupCollectionView() {
        
        collectionView?.register(ResumeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.isPagingEnabled = true
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        upGesture.direction = .up
        collectionView?.addGestureRecognizer(upGesture)
    }
    
    func setupViews() {
        let bottomStackView = UIStackView(arrangedSubviews: [backButton, editButton])
        view.addSubview(bottomStackView)

        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillEqually
        bottomStackView.spacing = 20

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
        return resumes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ResumeCell {
            cell.resume = resumes[indexPath.item]
            cell.viewUpdate()
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Open resume in ResumePresenter
        let resumePresentor = ResumePresentationVC()
       
        resumePresentor.modalPresentationStyle = .formSheet
        resumePresentor.modalTransitionStyle = .flipHorizontal
        resumePresentor.resume = resumes[currentCellIndex]
        
        present(resumePresentor, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension ChooseResumeVC {
    
    @objc func swipedUp() {
        let popup = PopupVC()
        popup.resume = resumes[currentCellIndex]
        present(popup, animated: true, completion: nil)
    }
    
    @objc func backButtonPressed() {
        present(forward: false)
    }
    
    @objc func editButtonPressed() {
        present(forward: true)
    }
    
    func present(forward: Bool) {
        if forward {
            guard let resume = resumes[currentCellIndex] else {
                //No resumes to edit, going back instead
                present(forward: false)
                return
            }
            
            let editResumeVC = EditResumeVC()
            resumeHandler.isEditingResume = true
            resumeHandler.currentResume = resume
            editResumeVC.resumeName = resume.resume_name
            present(editResumeVC, animated: true, completion: nil)
        } else {
            if let vc = presentingViewController as? MainVC {
                vc.updateData()
            }
            
            dismiss(animated: true, completion: nil)
            resumeHandler.isEditingResume = false
            resumeHandler.currentResume = nil
        }
    }
    
}
