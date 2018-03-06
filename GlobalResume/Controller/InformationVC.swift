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
    private var startAndEnd = (false, false)
    private var isStartDatePicker = true
    
    private var startDate: String? {
        willSet {
            updateTitle(forButton: startDateButton, with: newValue)
        }
    }
    
    private var endDate: String? {
        willSet {
            updateTitle(forButton: endDateButton, with: newValue)
        }
    }
    
    private var hasDatePicker: Bool {
        get {
            return startDateButton != nil && endDateButton != nil
        }
    }
    
    private let slidingAnimationDuration = 1.0
    private lazy var underScreenTransform = CGAffineTransform.init(translationX: 0, y: view.bounds.height)
    
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
    
   private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: view.center.y, width: view.frame.width, height: view.frame.height/2)
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        datePicker.transform = underScreenTransform
        return datePicker
    }()
    
    private lazy var datePickerViewBarView: UIView = {
        let view = UIView()
        let barHeight: CGFloat = 49
        view.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: barHeight)
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
      
        let button = UIButton(type: .system)
        let buttonWidth: CGFloat = 100
        let buttonFrame = CGRect(x: view.bounds.width - buttonWidth, y: 0, width: buttonWidth, height: barHeight)
        
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = buttonFrame
        button.addTarget(self, action: #selector(datePickerDoneButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        view.transform = underScreenTransform
        return view
    }()
    
    private var startDateButton: UIButton?
    private var endDateButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(true, animated: true)

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
        
        datePickerViewBarView.anchor(nil, left: view.leadingAnchor, bottom: datePicker.topAnchor, right: view.trailingAnchor, topConstant: 0, leftConstant: 0, bottomConsant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 49)
        
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
        view.addSubview(datePicker)
        view.addSubview(datePickerViewBarView)
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
            
            if button.titleLabel!.text!.contains("START") {
                startDateButton = button
            } else if button.titleLabel!.text!.contains("END") {
                endDateButton = button
            }
        }
        buttonInputView.setupViews()
    }
}

// MARK: - Targets
extension InformationVC {
    
    @objc private func datePickerValueChanged() {
        let date = dateFormatter(date: datePicker.date)
        if isStartDatePicker {
            startAndEnd.0 = true
            startDate = date
        } else {
            startAndEnd.1 = true
            endDate = date
        }
    }
    
    @objc func datePickerDoneButtonPressed() {
        
        UIView.animate(withDuration: slidingAnimationDuration, animations: {
            self.datePicker.transform = self.underScreenTransform
            self.datePickerViewBarView.transform = self.underScreenTransform
        })
        
        if allDatesHaveBeenSet() {
            handleTransportation(data: "\(startDate) - \(endDate)")
        }
        
        datePicker.superview?.isUserInteractionEnabled = true
    }
    
    // These targets are setup in KeyboardSetup
    @objc func doneButtonPressed() {
        guard let data = keyBoardInputView.inputTextField.text else { return }
        handleTransportation(data: data)
    }
    
    @objc func boxButtonPressed(_ button: UIButton) {
        guard let attributedText = button.titleLabel?.attributedText else { return }
        if hasDatePicker {
            
            if button == startDateButton {
                isStartDatePicker = true
            } else if button == endDateButton {
                isStartDatePicker = false
            }
            
            loadDatePicker()
            return
        }
        
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
    
    func updateTitle(forButton: UIButton?, with title: String?) {
        forButton?.setAttributedTitle(nil, for: .normal)
        forButton?.setTitle(title, for: .normal)
        forButton?.titleLabel?.textAlignment = .center
    }
    
    func handleTransportation(data: String) {
        guard let navigationController = navigationController as? CustomNavigationController else { return }
        let transitionHandler = TransitionHandler(navigationController: navigationController)
        transitionHandler.decideCourse(data: data)
    }
    
    func shouldTransition() {
        if startAndEnd == (true, true) {
            guard let startDate = startDateButton?.titleLabel?.text, let endDate = endDateButton?.titleLabel?.text else { return }
            let data = "\(startDate) - \(endDate)"
            handleTransportation(data: data)
        }
    }
    
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let string = formatter.string(from: date)
        return string
    }
    
    func loadDatePicker() {
        UIView.animate(withDuration: slidingAnimationDuration) {
            self.datePicker.transform = CGAffineTransform.identity
            self.datePickerViewBarView.transform = CGAffineTransform.identity
        }
    }
    
    func allDatesHaveBeenSet() -> Bool {
        return startAndEnd == (true, true)
    }
}
