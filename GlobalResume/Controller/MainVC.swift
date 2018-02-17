//
//  ViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/15/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class MainVC: UIViewController, ExamViewController {
    
    // MARK: Already Initialized Variables
    var modelManager: ModelManager<ModelExam>!
    
    lazy var backGroundImageView: UIImageView = {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = UIImage(named: "MainBG")
        return imageView
    }()
    
    lazy var personImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y+view.frame.height/2, width: view.frame.width, height: view.frame.height/2))
        imageView.image = UIImage(named: "Person")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Krungthep", size: 48)
        label.text = "EASY RESUME"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CREATE RESUME", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        animatePerson()
        animateTitle()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setupViews() {
        view.addSubview(backGroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(personImageView)
        view.addSubview(createButton)
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        createButton.topAnchor.constraint(equalTo: personImageView.topAnchor, constant: 20).isActive = true
        createButton.centerXAnchor.constraint(equalTo: personImageView.centerXAnchor).isActive = true
        createButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func updateViewsWithNewData() {}

}

// MARK: -
extension MainVC {
    
    @objc func createButtonPressed() {
        let transitionHandler = TransitionHandler(currentExamViewController: self)
        transitionHandler.decideCourse(data: nil)
    }
}

private extension MainVC {
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
