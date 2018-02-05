//
//  ResumePresentationVCViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/4/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit


class ResumePresentationVC: UIViewController, UIScrollViewDelegate {
    
    //Resume data up here
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
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.maximumZoomScale = 5.0
//        scrollView.minimumZoomScale = 1.0
        scrollView.contentSize.height = 1500
        return scrollView
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 1500)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        leftView.resume = resume
        rightView.resume = resume
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        setupViews()
        
        
        let holdDown = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(holdDown)
    }
    
    @objc func tapped() {
        dismiss(animated: true, completion: nil)
    }
    
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return mainView
//    }
    
    func setupViews() {
        
        let spacing: CGFloat = 10
        
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(mainView)
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        mainView.addSubview(leftView)
        mainView.addSubview(rightView)
        
        leftView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: spacing).isActive = true
        leftView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: spacing).isActive = true
        leftView.widthAnchor.constraint(equalTo: mainView.widthAnchor, constant: -view.frame.width/3).isActive = true
        
        
        
        rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: spacing).isActive = true
        rightView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: spacing).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        
    }
    
}




