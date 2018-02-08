//
//  ResumePresentationVCViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/4/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit


class ResumePresentationVC: UIViewController {
    
    var resume: ResumeData!
    
    let leftView: ResumeLeftView = {
        let view = ResumeLeftView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightView: ResumeRightView = {
        let view = ResumeRightView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize.height = view.frame.height * 2
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        leftView.resume = resume
        rightView.resume = resume
        view.backgroundColor = .white
        setupViews()
        registerGestures()
    }
    
    func setupViews() {
        let spacing: CGFloat = 10
        
        view.addSubview(scrollView)
        scrollView.addSubview(leftView)
        scrollView.addSubview(rightView)
        

        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        leftView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: spacing).isActive = true
        leftView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: spacing).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: view.frame.width / 3 * 2).isActive = true

        rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: spacing).isActive = true
        rightView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: spacing).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: view.frame.width / 3).isActive = true
    }
    
    func registerGestures() {
        let holdDown = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(holdDown)
    }
}
extension ResumePresentationVC: UIScrollViewDelegate {
    
    @objc func tapped() {
        dismiss(animated: true, completion: nil)
    }
//
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return mainView
//    }
//
}




