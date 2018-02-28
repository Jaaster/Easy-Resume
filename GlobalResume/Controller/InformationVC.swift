//
//  InformationVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class InformationVC: UIViewController, ExamViewController {
    
    private let emptyBox = "[   ] "
    private let checkedBox = "[X] "
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = UIImage(named: "TableBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.crayon.withSize(30)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editingPaper: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Papers")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let keyBoardInputView: KeyboardInputView = {
        let view = KeyboardInputView()
        view.translatesAutoresizingMaskIntoConstraints = false 
        return view
    }()
    
    private let buttonInputView: ButtonInputView = {
        let view = ButtonInputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view 
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func updateViewsWithNewData() {
        setupViews()
    }
}

// MARK: - Views
private extension InformationVC {
    
    func setupViews() {
        guard let navigationController = navigationController as? CustomNavigationController else { return }
        guard let currentModel = navigationController.modelManager.currentModel else { return }
        
        addSubViews()
        updateTitleText(currentModel: currentModel)
        
        editingPaper.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, right: view.safeAreaLayoutGuide.trailingAnchor, topConstant: 20, leftConstant: 10, bottomConsant: 0, rightConstant: -10, widthConstant: 0, heightConstant: view.frame.height/2)
        
        if getInputType() == .keyboard {
            
            titleLabel.anchor(editingPaper.topAnchor, left: editingPaper.leadingAnchor, bottom: nil, right: editingPaper.trailingAnchor, topConstant: 50, leftConstant: 45, bottomConsant: 0, rightConstant: -45, widthConstant: 0, heightConstant: 35)
            keyBoardInputView.anchor(titleLabel.bottomAnchor, left: titleLabel.leadingAnchor, bottom: nil, right: titleLabel.trailingAnchor, topConstant: 20, leftConstant: 0, bottomConsant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 45)
            
            buttonInputView.removeFromSuperview()
            updateViewsForKeyboardInput(currentModel: currentModel)
        } else {
            buttonInputView.allEdgesConstraints(parentView: editingPaper, spacing: 45)
            titleLabel.anchor(editingPaper.topAnchor, left: buttonInputView.leadingAnchor, bottom: nil, right: buttonInputView.trailingAnchor, topConstant: 50, leftConstant: 0, bottomConsant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 35)
            keyBoardInputView.removeFromSuperview()
            updateViewsForButtonInput(currentModel: currentModel)
        }
    }
    
    func addSubViews() {
        view.addSubview(bgImageView)
        view.addSubview(editingPaper)
        view.addSubview(keyBoardInputView)
        view.addSubview(buttonInputView)
        view.addSubview(titleLabel)
    }
    
    func updateTitleText(currentModel: ExamModel) {
        titleLabel.text = currentModel.title
        titleLabel.textColor = currentModel.color
    }
    
    func updateViewsForKeyboardInput(currentModel: ExamModel) {
        
        let keyboard = KeyboardSetup(textField: keyBoardInputView.inputTextField, textView: nil, viewController: self)
        keyboard?.setup()
        
        keyBoardInputView.inputTextField.text = ""
        keyBoardInputView.inputTextField.placeholder = "e.g something"
        keyBoardInputView.inputTextField.textColor = currentModel.color
        keyBoardInputView.inputTextField.delegate = self
    }
    
    func updateViewsForButtonInput(currentModel: ExamModel) {
        guard let buttonModels = currentModel.buttonModels else { return }
        buttonInputView.buttons = []
        
        for i in 0..<buttonModels.count {
            buttonInputView.addButton()
            let button = buttonInputView.buttons[i]
            let attributes = emptyBox.myAttributedString(color: .gray, font: UIFont.crayon)
            let titleAttributes = buttonModels[i].title.myAttributedString(color: buttonModels[i].color, font: UIFont.crayon)
            attributes.append(titleAttributes)
            
            button.setAttributedTitle(attributes, for: .normal)
            button.addTarget(self, action: Selector(("boxButtonPressed:")), for: .touchUpInside)
        }
        buttonInputView.setupViews()
    }
}

// MARK: - Targets, these targets are added in KeyboardSetup
extension InformationVC {
    @objc func doneButtonPressed() {
        guard let data = keyBoardInputView.inputTextField.text else { return }
        handleTransportation(data: data)
    }
    
    @objc func boxButtonPressed(_ button: UIButton) {
        guard let attributedText = button.titleLabel?.attributedText else { return }
        let boxAttributes = attributedText.attributedSubstring(from: NSRange(0..<emptyBox.count)) as? NSMutableAttributedString
        boxAttributes?.mutableString.setString(checkedBox)
        
        let titleAttributes = attributedText.attributedSubstring(from: NSRange(emptyBox.count..<attributedText.string.count))
        boxAttributes?.append(titleAttributes)
        
        button.setAttributedTitle(boxAttributes, for: .normal)
        button.superview?.isUserInteractionEnabled = false
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when, execute: {
            let data = titleAttributes.string
            button.superview?.isUserInteractionEnabled = true
            self.handleTransportation(data: data)
        })
    }
}

// MARK: - Delegates
extension InformationVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let data = textField.text {
            if !data.isEmpty{
                textField.endEditing(true)
                handleTransportation(data: data)
                return true
            }
        }
        return false
    }
}

private extension InformationVC {
    
    enum InputType {
        case keyboard
        case button
    }
    
    func getInputType() -> InputType {
        guard let navigationController = navigationController as? CustomNavigationController else { return .keyboard }
        guard let currentModel = navigationController.modelManager.currentModel else { return .keyboard}
        
        if hasButtonModels(modelExam: currentModel) {
            return .button
        } else {
            return .keyboard
        }
    }
    
    func hasButtonModels(modelExam: ExamModel) -> Bool {
        return modelExam.buttonModels != nil
    }
    
    func handleTransportation(data: String) {
        guard let navigationController = navigationController as? CustomNavigationController else { return }
        let transitionHandler = TransitionHandler(navigationController: navigationController)
        transitionHandler.decideCourse(data: data)
    }
}
