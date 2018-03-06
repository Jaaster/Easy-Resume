//
//  LoginVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/14/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    private var registeringToggle = false
    
    private lazy var bgImage: UIImageView = {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = UIImage(named: "MainBG")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.darkGray
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white.withAlphaComponent(0.7)])
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.darkGray
        textField.textColor = .white
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white.withAlphaComponent(0.7)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.darkGray
        button.titleLabel?.font = button.titleLabel?.font.withSize(20)
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleUserAuthentication), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var swapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(swapButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = true
        setupDelegates()
        setupViews()
    }
}

// MARK: - Targets
extension LoginVC {
    @objc private func handleUserAuthentication() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }

        if registeringToggle {
           register(email: email, password: password)
        } else {
            login(email: email, password: password)
        }
    }
    
    @objc private func swapButtonPressed() {
        registeringToggle = !registeringToggle
        
        if registeringToggle {
            authButton.setTitle("REGISTER", for: .normal)
            swapButton.setTitle("Already registered?", for: .normal)
        } else {
            authButton.setTitle("LOGIN", for: .normal)
            swapButton.setTitle("Don't have an account?", for: .normal)
        }
    }
}

// MARK: - Views and Animations
private extension LoginVC {
    
    func setupViews() {
        addSubviews()
        
        let spacing: CGFloat = 5
        let inputContainerHeight: CGFloat = 100
        let textFieldHeight: CGFloat = inputContainerHeight/2 - spacing

        inputContainerView.anchor(view.centerYAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, topConstant: 0, leftConstant: 10, bottomConsant: 0, rightConstant: -10, widthConstant: 0, heightConstant: inputContainerHeight)
       
        emailTextField.anchor(inputContainerView.topAnchor, left: inputContainerView.leadingAnchor, bottom: nil, right: inputContainerView.trailingAnchor, topConstant: spacing, leftConstant: spacing * 2, bottomConsant: 0, rightConstant: -spacing * 2, widthConstant: 0, heightConstant: textFieldHeight)
        
        passwordTextField.anchor(emailTextField.bottomAnchor, left: emailTextField.leadingAnchor, bottom: nil, right: emailTextField.trailingAnchor, topConstant: spacing, leftConstant: 0, bottomConsant: 0, rightConstant: 0, widthConstant: 0, heightConstant: textFieldHeight)
        
        authButton.anchor(inputContainerView.bottomAnchor, left: inputContainerView.leadingAnchor, bottom: nil, right: inputContainerView.trailingAnchor, topConstant: spacing, leftConstant: 0, bottomConsant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        swapButton.anchor(authButton.bottomAnchor, left: authButton.leadingAnchor, bottom: nil, right: authButton.trailingAnchor, topConstant: 10, leftConstant: 0, bottomConsant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 10)
    }
    
    func addSubviews() {
        view.addSubview(bgImage)
        view.addSubview(inputContainerView)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(passwordTextField)
        view.addSubview(authButton)
        view.addSubview(swapButton)
    }
    
    func animateSwapButtonTitle() {
        let duration = 0.25
        swapButton.expandAnimation(duration: duration, scaleX: 1.3, y: 1.3)
    }
}

// MARK: - User Authentication
private extension LoginVC {
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                self.animateSwapButtonTitle()
                return
            }
            self.navigationController?.pushViewController(MainVC(), animated: true)
            self.createUserInDatabase()
        }
    }
    
    func createUserInDatabase() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child(FIRDataReferencePath.users.rawValue).child(uid)
        ref.updateChildValues([FIRDataReferencePath.resumes.rawValue : 0]) { (error, ref) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                self.animateSwapButtonTitle()
                return
            }
            self.navigationController?.pushViewController(MainVC(), animated: true)
        }
    }
}

// MARK: - Delegates
extension LoginVC: UITextFieldDelegate {
    private func setupDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

