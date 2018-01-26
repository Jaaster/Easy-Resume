
//
//  DescriptionVCViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/23/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class DescriptionVCViewController: UIViewController, LoadableVC {
    
    var loadingViewColor: UIColor!
    var currentExam: Exam!
    
    var examples = [String]()

    @IBOutlet var loadingView: LoadView!
    @IBOutlet weak var examplesView: ExampleView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var exampleButton: CircleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        loadingView.backgroundColor = loadingViewColor
    }
    
    func toolBar() {
        let toolBar = UIToolbar()
        
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
       
        toolBar.sizeToFit()
        toolBar.setItems([flexibleSpace, button], animated: false)
        
        textField.inputAccessoryView = toolBar
        
        
    }
    
    @objc func doneButtonPressed() {
        textField.endEditing(true)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        examplesView.fade(alpha: 0.0)
    }
    

    @IBAction func exampleButtonPressed(_ sender: CircleButton) {
        examplesView.isHidden = false
        examplesView.fade(alpha: 1.0)
    }
    
    
}

extension DescriptionVCViewController: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        examplesView.fade(alpha: 0.0)
        textField.text = examples[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell") as? ExampleCell {
            cell.exampleLabel.text = examples[indexPath.row]
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


