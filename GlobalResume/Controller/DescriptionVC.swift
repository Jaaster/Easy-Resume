
//
//  DescriptionVCViewController.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 1/23/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController, ExamViewController {

    private var examples = [String]()
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = UIImage(named: "TableBackgroundZoomedIn")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.crayon.withSize(30)
        label.text = "Job Description"
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionTextView: UITextView = {
       let textView = UITextView()
        textView.font = UIFont.crayon.withSize(18)
        textView.textAlignment = .center
        textView.textColor = .gray
        let keyboardSetup = KeyboardSetup(textField: nil, textView: textView, viewController: self)
        keyboardSetup?.setup()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
   private lazy var phoneImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        imageView.image = phoneImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let phoneImage: UIImage? = {
        let image = UIImage(named: "Phone")
        return image
    }()
    
    private let phoneRingingImage: UIImage? = {
        let image = UIImage(named: "RingingPhone")
        return image
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "NextButton"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableContentsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var phoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(phoneButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var examplesView: DescriptionExamplesView = {
        let view = DescriptionExamplesView(frame: self.view.frame)
        view.isUserInteractionEnabled = false
        view.transform = view.descriptionExamplesTransform
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        examplesView.examplesTableView.delegate = self
        examplesView.examplesTableView.dataSource = self
        updateViewsWithNewData()
    }
    
    func updateViewsWithNewData() {
        view.removeSubviews()
        guard let navigationController = navigationController as? CustomNavigationController else { return }
        if let currentModel = navigationController.modelManager.currentModel {
            titleLabel.text = currentModel.title
            if let descriptions = currentModel.descriptions {
                examples = descriptions
            }
        }
        setupViews()
    }
}

// MARK: - Setup Views
private extension DescriptionVC {
    
    func addSubViews() {
        view.addSubview(bgImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(tableContentsContainer)
        
        tableContentsContainer.addSubview(phoneImageView)
        tableContentsContainer.addSubview(phoneButton)
        tableContentsContainer.addSubview(nextButton)
        
        view.addSubview(examplesView)
    }
    
    func setupViews() {
        
        addSubViews()
        let spacing: CGFloat = 30
        
        titleLabel.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, topConstant: spacing, leftConstant: spacing, bottomConsant: 0, rightConstant: -spacing, widthConstant: 0, heightConstant: 35)
        
        descriptionTextView.anchor(titleLabel.bottomAnchor, left: view.leadingAnchor, bottom: nil, right: view.trailingAnchor, topConstant: spacing/2, leftConstant: spacing, bottomConsant: 0, rightConstant: -spacing, widthConstant: 0, heightConstant: view.frame.height/2-7)
        
        tableContentsContainer.anchor(descriptionTextView.bottomAnchor, left: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.trailingAnchor, topConstant: 40, leftConstant: 0, bottomConsant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        phoneImageView.centerYAnchor.constraint(equalTo: tableContentsContainer.centerYAnchor).isActive = true
        phoneImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        phoneImageView.leadingAnchor.constraint(equalTo: tableContentsContainer.leadingAnchor, constant: spacing).isActive = true
        
        phoneButton.allEdgesConstraints(parentView: phoneImageView, spacing: 0)
        
        nextButton.centerYAnchor.constraint(equalTo: tableContentsContainer.centerYAnchor).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: tableContentsContainer.trailingAnchor, constant: -spacing).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 89).isActive = true
    }
    
    func setupTimerForPhoneAnimation() {
        timeToShakePhone()
        let _ = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(timeToShakePhone), userInfo: nil, repeats: true)
    }
}
// MARK: - Targets
extension DescriptionVC {
    
    // MARK: - Will present Examples
    @objc private func phoneButtonPressed() {
        examplesView.raisePhone()
    }
    
    @objc private func nextButtonPressed() {
        if let data = descriptionTextView.text {
            if !data.isEmpty {
                guard let navigationController = navigationController as? CustomNavigationController else { return }
                let transition = TransitionHandler(navigationController: navigationController)
                transition.decideCourse(data: data)
            }
        }
    }
    
    @objc private func timeToShakePhone() {
        phoneImageView.image = phoneRingingImage
        phoneImageView.shake(rotationDegrees: 25.0, duration: 0.05, count: 10, completion: {
            self.phoneImageView.image = self.phoneImage
        })
    }
    
    @objc func doneButtonPressed() {
        descriptionTextView.endEditing(true)
    }
}
// MARK: - Datasources
extension DescriptionVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exampleCell", for: indexPath) as! ExampleCell
        cell.textLabel?.text = examples[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
    
        let previousText = descriptionTextView.text
        let cellText = cell.textLabel?.text
        
        descriptionTextView.text = previousText! + cellText!
        examplesView.lowerPhone()
    }
}
