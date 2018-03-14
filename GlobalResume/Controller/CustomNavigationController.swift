//
//  CustomNavigationController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    var currentResume: ResumeData?
    let transition = CustomTransition()
    var modelManager = ModelManager<ExamModel>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitioningDelegate = self
        toolbar.isTranslucent = true
        toolbar.barStyle = .black
        
    }
    
    override func viewDidLayoutSubviews() {
        toolbar.setItems(createBarButtons(), animated: true)
    }
}

extension CustomNavigationController {
    
    @objc func handleUserSettingsButton() {
        
    }
    
    @objc func handleResumesButton() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let resumeVC = ResumesVC(collectionViewLayout: layout)
        pushViewController(resumeVC, animated: true)
    }
    
    @objc func handleJobsButton() {
        
        
    }
}
private extension CustomNavigationController {
    
    func createBarButtons() -> [UIBarButtonItem] {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let settings = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(handleUserSettingsButton))
        let resumes = UIBarButtonItem(title: "Resumes", style: .plain, target: self, action: #selector(handleResumesButton))
        let jobs = UIBarButtonItem(title: "Jobs", style: .plain, target: self, action: #selector(handleJobsButton))
        
        return [settings, flexibleSpace, resumes, flexibleSpace, jobs]
    }
}

extension CustomNavigationController: UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
}
