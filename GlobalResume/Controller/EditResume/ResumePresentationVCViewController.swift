//
//  ResumePresentationVCViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/4/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit


class ResumePresentationVC: UIViewController {
    
    //Resume data up here
    var resume: ResumeData!
    
    
    let leftView: ResumeLeftView = {
        let view = ResumeLeftView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let rightView: ResumeRightView = {
        let view = ResumeRightView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .lightGray
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize.height = 1500
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftView.resume = resume
        rightView.resume = resume
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        setupViews()
        leftView.loadData()
    }
    
    
    func setupViews() {
        
        let spacing: CGFloat = 10
        
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        scrollView.addSubview(leftView)
        scrollView.addSubview(rightView)
        
        leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing).isActive = true
        leftView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: spacing).isActive = true
        leftView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -view.frame.width/3).isActive = true
        
        
        
        rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: spacing).isActive = true
        rightView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: spacing).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: view.frame.width/4).isActive = true
        
    }
    
}




