
//
//  DescriptionVCViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/23/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class DescriptionVCViewController: UIViewController, LoadableVC {
    
    var currentExam: Exam!
    var presenting: UIViewController!
    private var examples = [String]()

    @IBOutlet weak var examplesView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var exampleButton: CustomButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        handlePreviousController()

        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
     func updateData() {
        addToolBarToKeyboard()
        
        let shared = OneInstance.shared
        switch currentExam {
        case .jobDescription:
            examples = shared.exampleJobList.sorted()
        case .educationDescription:
            examples = shared.exampleEducationDescriptionList.sorted()
        case .profileDescription:
            examples = shared.exampleProfileDescriptionList.sorted()
        default:
            break
        }
      
        if let first = examples.first {
            textField.text = "e.g \(first)"
        }
        
        let values = currentExam.getValues()
        let color = values.color
        
        titleLabel.text = currentExam.rawValue
        
        examplesView.alpha = 0.0
        examplesView.isHidden = true
        
        exampleButton.backgroundColor = color
        exampleButton.round()
        exampleButton.setTitle(values.example, for: .normal)
        exampleButton.titleLabel?.adjustsFontSizeToFitWidth = true
        exampleButton.titleLabel?.textAlignment = .center
        
        nextButton.isHidden = true
        backButton.setTitleColor(color, for: .normal)
        nextButton.setTitleColor(color, for: .normal)
        titleLabel.textColor = color
    
        backgroundView.backgroundColor = color
        tableView.reloadData()
    }
    
    func addToolBarToKeyboard() {
        let toolBar = UIToolbar()
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.sizeToFit()
        toolBar.setItems([flexibleSpace, button], animated: false)
        
        textField.inputAccessoryView = toolBar
    }
}

extension DescriptionVCViewController: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        handleTransportation(data: textField.text)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        examplesView.fade(alpha: 0.0)
    }
    
    @IBAction func exampleButtonPressed(_ sender: CustomButton) {
        examplesView.isHidden = false
        examplesView.fade(alpha: 1.0)
    }
    
    @objc func doneButtonPressed() {
        textField.endEditing(true)
        nextButton.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        examplesView.fade(alpha: 0.0)
        textField.text = examples[indexPath.row]
        nextButton.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell") as? ExampleCell {
            cell.exampleLabel.text = examples[indexPath.row]
            cell.exampleLabel.backgroundColor = currentExam.getValues().color
            return cell
        }
        
        return ExampleCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
