////
////  EditResumeVC.swift
////  GlobalResume
////
////  Created by Joriah Lasater on 2/1/18.
////  Copyright © 2018 Joriah Lasater. All rights reserved.
////
//
import UIKit

class EditResumeVC: UIViewController {

    typealias color = UIColor
    
    var currentResumeModel: ResumeModel! 
    
    var currentEmploymentModel: EmploymentModel?
    var currentEducationModel: EducationModel?
    
    private let resumeModelHandler = ResumeModelHandler()
    
    private let addButtonTitle = "ADD"
    private let backButtonTitle = "BACK"
    private let cellID = "editResumeCell"

    var buttons: [String] {
        get {
            if propertiesType == .editEmployment || propertiesType == .editEducation {
                return [backButtonTitle]
            }
            return [addButtonTitle, backButtonTitle]
        }
    }
    
    var propertiesType: PropertiesType! {
        willSet {
            if !newValue.rawValue.isEmpty {
                titleLabel.text = newValue.rawValue
            }
        }
    }
    
    var propertiesForCells: [String] {
        get {
            let result: [String]
            switch propertiesType {
            case .menu:
                result = PropertiesType.values()
            case .educationList:
                result = resumeModelHandler.educationSchoolNames(ofResume: currentResumeModel)
            case .employmentList:
                result = resumeModelHandler.employmentCompanyNames(ofResume: currentResumeModel)
            case .contactInfo:
                result = resumeModelHandler.contactInfoValues(ofResume: currentResumeModel)
            case .editEmployment:
                result = resumeModelHandler.employmentValues(ofEmployment: currentEmploymentModel)
            default:
                return []
            }
            
            return result + buttons
        }
    }
    
    var descriptionsForCells: [String] {
        get {
            var result = [String]()
            
            switch propertiesType {
            case .menu:
                    return []
            case .educationList:
                let models = Array(currentResumeModel.educationModels!) as! [EducationModel]
                for model in models {
                    if let name = model.schoolName {
                        result.append(name)
                    }
                }
            case .employmentList:
                let models = Array(currentResumeModel.employmentModels!) as! [EmploymentModel]
                for model in models {
                    if let name = model.companyName {
                        result.append(name)
                    }
                }
                
            case .editEmployment:
                guard let employmentModel = currentEmploymentModel else {return []}
                result = Array(employmentModel.entity.attributesByName.keys)
            case .contactInfo:
                result = Array(currentResumeModel.entity.attributesByName.keys).filter  { currentResumeModel.value(forKey: $0) != nil && $0 != "resumeName" }
            default :
                return []
            }
            
            return result.map({ (value) -> String in
                return value.titleCase
            })
        }
    }
    

    lazy var titleLabel: UILabel = {
        var label = UILabel()
        let font = UIFont.myFontRegular.withSize(35)
        label.textColor = .black
        label.font = font
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EditResumeCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        var indexPaths = [IndexPath]()
        for index in descriptionsForCells.indices {
            indexPaths.append(IndexPath(item: index, section: 0))
        }
        collectionView.reloadItems(at: indexPaths)
    }
    
    override func viewDidLayoutSubviews() {
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(collectionView)

        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 35).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
    }
    enum PropertiesType: String  {
        case educationList = "Education"
        case editEducation = "Edit Education"
        case editEmployment = "Edit Employment"
        case employmentList = "Employment"
        
        case contactInfo = "Contact Info"
        case menu = ""
        
        static func values() -> [String] {
            return [PropertiesType.contactInfo.rawValue, PropertiesType.educationList.rawValue, PropertiesType.employmentList.rawValue]
        }
    }
}

extension EditResumeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func edit(resume: ResumeModel, exam: Exam) {
        guard let navigationController = navigationController as? CustomNavigationController else { return }
        guard let modelExam = navigationController.modelManager.modelFrom(exam: exam) else { return }
        
        let transitionHandler = TransitionHandler(navigationController: navigationController)
        navigationController.isEditingCurrentResume = true
        // Issue with updating data in firebase. 
        if let resumeData = navigationController.currentResume {
            resumeData.resumeName = currentResumeModel.resumeName!
            
            if let currentEmploymentModel = currentEmploymentModel {
                resumeData.currentEmployment = currentEmploymentModel
            } else if let currentEducationModel = currentEducationModel {
                resumeData.currentEducation = currentEducationModel
            }
        } else {
            
            
        }
        
        transitionHandler.transitionTo(nextModelExam: modelExam, data: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            let cellTitle = buttons[indexPath.row]
            if cellTitle == addButtonTitle {
                return
            } else if cellTitle == backButtonTitle {
                navigationController?.popViewController(animated: true)
                return
            }
        }
        
        if propertiesType == .contactInfo {
            let cellDescription = descriptionsForCells[indexPath.row]
                if let exam = Exam(rawValue: cellDescription) {
                    edit(resume: currentResumeModel, exam: exam)
                    return
                }
        } else if propertiesType == .editEmployment || propertiesType == .editEducation {
            let cellDescription = descriptionsForCells[indexPath.row]
            if let exam = Exam(rawValue: cellDescription) {
                edit(resume: currentResumeModel, exam: exam)
                return
            }
        }

        let vc = EditResumeVC()
        
        vc.currentResumeModel = currentResumeModel
        if let property = PropertiesType.init(rawValue: propertiesForCells[indexPath.row]) {
            vc.propertiesType = property
            
        } else {
            
            if propertiesType == .employmentList {
                let models = Array(currentResumeModel.employmentModels!)
                vc.currentEmploymentModel = models[indexPath.row] as? EmploymentModel
                vc.propertiesType = .editEmployment
            } else if propertiesType == .educationList {
                let models = Array(currentResumeModel.educationModels!)
                vc.currentEducationModel = models[indexPath.row] as? EducationModel
                vc.propertiesType = .editEducation
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? EditResumeCell {
            let index = indexPath.row
            var titleText: String = ""
            
            if indexPath.section == 0 {
                titleText = propertiesForCells[index]
                if index < descriptionsForCells.count {
                    cell.describingLabel.text = descriptionsForCells[index]
                }
            } else if indexPath.section == 1 {
                titleText = buttons[index]
                cell.describingLabel.text = ""
            }
            
          
            cell.titleLabel.text = "[\(titleText)]"
            
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return propertiesForCells.count-buttons.count
        }
        
        return buttons.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
