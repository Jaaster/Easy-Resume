//
//  DescriptionExamplesView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/17/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class DescriptionExamplesView: UIView {
    
    lazy var descriptionExamplesTransform: CGAffineTransform = CGAffineTransform(translationX: 0.0, y: frame.height)
    
    lazy var phoneAndHandView: UIView = {
        let view = UIView(frame: frame)
        view.backgroundColor = .clear
        return view
    }()
    
//    lazy var handHoldingPhoneImageView: UIImageView = {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 385, height: 550))
//
//        imageView.image = UIImage(named: "HandHoldingPhone")
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = .blue
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    lazy var phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.bounds = CGRect(x: 0, y: 0, width: bounds.width/7*5, height: bounds.height/5*4)
        imageView.center = phoneAndHandView.center
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "BigPhone")
        return imageView
    }()
    
    lazy var phoneScreenImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: phoneImageView.bounds.width-9, height: phoneImageView.bounds.height/6 * 4))
        imageView.center = phoneImageView.center
        imageView.image = UIImage(named: "PhoneScreen")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
//    let fingersOverPhoneImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "FingersOverPhone")
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.myFontRegular.withSize(25)
        label.text = "EXAMPLES"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let examplesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(ExampleCell.self, forCellReuseIdentifier: "exampleCell")
        return tableView
    }()
    
    let homeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(homePhoneButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isUserInteractionEnabled {
            
            if homeButton.frame.contains(point) {
                return homeButton
            }
            
            return examplesTableView
        }
        return super.hitTest(point, with: event)
    }
}

private extension DescriptionExamplesView {
    
    func setupViews() {
        
//        phoneAndHandView.addSubview(handHoldingPhoneImageView)
        
        phoneAndHandView.addSubview(phoneImageView)
        phoneAndHandView.addSubview(phoneScreenImageView)
        
        addSubview(phoneAndHandView)
        addSubview(homeButton)
        addSubview(titleLabel)
        addSubview(examplesTableView)
//        addSubview(fingersOverPhoneImageView)

        titleLabel.topAnchor.constraint(equalTo: phoneScreenImageView.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: phoneScreenImageView.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true

        examplesTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        examplesTableView.leadingAnchor.constraint(equalTo: phoneScreenImageView.leadingAnchor, constant: 5).isActive = true
        examplesTableView.trailingAnchor.constraint(equalTo: phoneScreenImageView.trailingAnchor, constant: -10).isActive = true
        examplesTableView.bottomAnchor.constraint(equalTo: phoneScreenImageView.bottomAnchor, constant: -10).isActive = true
        
        homeButton.centerXAnchor.constraint(equalTo: phoneImageView.centerXAnchor).isActive = true
        homeButton.topAnchor.constraint(equalTo: phoneScreenImageView.bottomAnchor, constant: 10).isActive = true
        homeButton.bottomAnchor.constraint(equalTo: phoneImageView.bottomAnchor, constant: -10).isActive = true
        homeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
}

extension DescriptionExamplesView {
   
    @objc private func homePhoneButtonPressed() {
        lowerPhone()
    }
    
    func lowerPhone() {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.7) {
            self.transform = self.descriptionExamplesTransform
        }
    }
    
    func raisePhone() {
        isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.7) {
            self.transform = CGAffineTransform.identity
        }
    }
}
