//
//  InformationVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/16/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class InformationVC: UIViewController, ExamViewController {
    
    var modelManager: ModelManager<ModelExam>!
    let box = "[   ]"
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = UIImage(named: "TableBackground")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let editingPaper: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Editing Paper")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let keyBoardInputView: KeyboardInputView = {
        let view = KeyboardInputView()
        view.translatesAutoresizingMaskIntoConstraints = false 
        return view
    }()
    
    let buttonInputView: ButtonInputView = {
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
    
    @objc func doneButtonPressed() {
        guard let data = keyBoardInputView.inputTextField.text else { return }
        
        handleTransportation(data: data)
    }
    
    @objc func buttonPressed(_ button: UIButton) {
            guard var data = button.titleLabel?.text else { return }
            data = data.replacingOccurrences(of: box, with: "[X]")
            button.setTitle(data, for: .normal)
        
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                data = data.replacingOccurrences(of: "[X]", with: "")
                self.handleTransportation(data: data)
            })
     
    }
}

private extension InformationVC {
    func setupViews() {
        guard let currentModel = modelManager.currentModel else { return }
        
        view.addSubview(bgImageView)
        view.addSubview(editingPaper)
        view.addSubview(keyBoardInputView)
        view.addSubview(buttonInputView)
        
        editingPaper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        editingPaper.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        editingPaper.widthAnchor.constraint(equalToConstant: view.frame.width-40).isActive = true
        

        if getInputType() == .keyboard {
            buttonInputView.removeFromSuperview()
            keyBoardInputView.allEdgesConstraints(parentView: editingPaper, spacing: 5)
            keyBoardInputView.titleLabel.text = currentModel.title
            keyBoardInputView.titleLabel.textColor = currentModel.color
            updateViewsForKeyboardInput(currentModel: currentModel)
        } else {
            keyBoardInputView.removeFromSuperview()
            buttonInputView.allEdgesConstraints(parentView: editingPaper, spacing: 5)
            buttonInputView.titleLabel.text = currentModel.title
            buttonInputView.titleLabel.textColor = currentModel.color
            updateViewsForButtonInput(currentModel: currentModel)
        }
    }
    
    func updateViewsForKeyboardInput(currentModel: ModelExam) {
        
        let keyboard = Keyboard(textField: keyBoardInputView.inputTextField, examViewController: self)
        keyboard?.setup()
        
        keyBoardInputView.inputTextField.text = ""
        keyBoardInputView.inputTextField.placeholder = "e.g something"
        keyBoardInputView.inputTextField.textColor = currentModel.color
        keyBoardInputView.inputTextField.delegate = self
    }
    
    func updateViewsForButtonInput(currentModel: ModelExam) {
        guard let buttonModels = currentModel.buttonModels else { return }
        buttonInputView.buttons = []
        
        for i in 0..<buttonModels.count {
            buttonInputView.addButton()
            let button = buttonInputView.buttons[i]
            button.setTitle("\(box)\(buttonModels[i].title)", for: .normal)
            button.setTitleColor(buttonModels[i].color, for: .normal)
            button.addTarget(self, action: Selector(("buttonPressed:")), for: .touchUpInside)
        }
        buttonInputView.setupViews()
    }
}

private extension InformationVC {
    
    enum InputType {
        case keyboard
        case button
    }
    
    func getInputType() -> InputType {
        guard let currentModel = modelManager.currentModel else { return .keyboard}
        
        if hasButtonModels(modelExam: currentModel) {
            return .button
        } else {
            return .keyboard
        }
    }
    
    func hasButtonModels(modelExam: ModelExam) -> Bool {
        return modelExam.buttonModels != nil
    }
    
    func handleTransportation(data: String) {
        let transitionHandler = TransitionHandler(currentExamViewController: self)
        transitionHandler.decideCourse(data: data)
    }
}
