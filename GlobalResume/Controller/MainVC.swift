//
//  ViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainVC: UIViewController {
    
    // MARK: Already Initialized Variables
    
    var isUserAuthenticated: Bool {
        return Auth.auth().currentUser?.uid != nil
    }

    private lazy var backGroundImageView: UIImageView = {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = UIImage(named: "MainBG")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var personImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y+view.frame.height/2, width: view.frame.width, height: view.frame.height/2))
        imageView.image = UIImage(named: "Person")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Krungthep", size: 48)
        label.text = "EASY RESUME"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CREATE RESUME", for: .normal)
        button.titleLabel?.font = UIFont.crayon.withSize(20)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(false, animated: true)
        if !isUserAuthenticated {
            navigationController?.pushViewController(LoginVC(), animated: true)
        }
        
        setupViews()
        animatePerson()
        animateTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Targets
extension MainVC {
    
    @objc private func createButtonPressed() {
        guard let navigationController = navigationController as? CustomNavigationController else { return }
        let transitionHandler = TransitionHandler(navigationController: navigationController)
        transitionHandler.decideCourse(data: nil)
    }
}

// MARK: - Views and Animations
private extension MainVC {
    
    func setupViews() {
        addSubViews()
        
        titleLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, topConstant: 0, leftConstant: 10, bottomConsant: 0, rightConstant: -10, widthConstant: 0, heightConstant: 75)
        
        createButton.topAnchor.constraint(equalTo: personImageView.topAnchor, constant: 20).isActive = true
        createButton.centerXAnchor.constraint(equalTo: personImageView.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func addSubViews() {
        view.addSubview(backGroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(personImageView)
        view.addSubview(createButton)
    }
    
    func animatePerson() {
        let transform = CGAffineTransform(translationX: 0.0, y: view.frame.height/2)
        personImageView.transform = transform
        createButton.transform = transform
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.1, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.personImageView.transform = CGAffineTransform.identity
            self.createButton.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func animateTitle() {
        titleLabel.alpha = 0.0
        UIView.animate(withDuration: 1.5) {
            self.titleLabel.alpha = 1.0
        }
    }
}
