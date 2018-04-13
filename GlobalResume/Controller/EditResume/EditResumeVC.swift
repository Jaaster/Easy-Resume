////
////  EditResumeVC.swift
////  GlobalResume
////
////  Created by Joriah Lasater on 2/1/18.
////  Copyright © 2018 Joriah Lasater. All rights reserved.
////
//
import UIKit
import CoreData

class EditResumeVC: UIViewController {

    typealias color = UIColor
    
    var currentResumeModel: ResumeModel! 
    var currentEmploymentModel: EmploymentModel?
    var currentEducationModel: EducationModel?
    
    private let resumeModelHandler = ResumeModelHandler()
    private let cellID = "editResumeCell"
    private let unwantedPropertiesForCells = ["uid"]
   
    var toolbarTitle: String? {
        switch propertiesType {
        case .editEducation:
            return currentEducationModel?.schoolName
        case .editEmployment:
            return currentEmploymentModel?.companyName
        case .menu:
            return currentResumeModel.resumeName! + " Info"
        default:
            return propertiesType.rawValue
        }
    }
    
    var propertiesType: PropertiesType!
    
    var propertiesForCells: [(title: String, description: String)] {
        get {
            var result = [(title: String, description: String)]()
            switch propertiesType {
            case .menu:
                result = PropertiesType.values()
            case .educationList:
                result = resumeModelHandler.educationSchoolNames(ofResume: currentResumeModel)
            case .employmentList:
                result = resumeModelHandler.employmentCompanyNames(ofResume: currentResumeModel)
            case .personalInfo:
                result = resumeModelHandler.contactInfoValues(ofResume: currentResumeModel, filter: unwantedPropertiesForCells)
            case .editEmployment:
                result = resumeModelHandler.employmentValues(ofEmployment: currentEmploymentModel, filter: unwantedPropertiesForCells)
            default:
                return []
            }
            
            return result
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
                result = Array(employmentModel.entity.attributesByName.keys).filter({!unwantedPropertiesForCells.contains($0)})
            case .personalInfo:
                result = Array(currentResumeModel.entity.attributesByName.keys).filter  {!unwantedPropertiesForCells.contains($0) }
            default :
                return []
            }
            
            return result.map({ (value) -> String in
                return value.titleCase
            })
        }
    }

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    var isAddButtonAllowed: Bool {
        get {
            return propertiesType == .educationList || propertiesType == .employmentList
        }
    }
    
    var isTrashButtonAllowed: Bool {
        get {
            return propertiesType == .editEducation || propertiesType == .editEmployment
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EditResumeCell.self, forCellWithReuseIdentifier: cellID)
        navigationItem.title = toolbarTitle
        extendedLayoutIncludesOpaqueBars = true
        
        if isAddButtonAllowed {
            navigationItem.rightBarButtonItem = createAddButton()
        } else if isTrashButtonAllowed {
            navigationItem.rightBarButtonItem = createTrashButton()
        }
    }
    
    func createAddButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addModel))
    }

    func createTrashButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteModel))

    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
    }
    
    override func viewDidLayoutSubviews() {
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)

        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    }

    enum PropertiesType: String {
        case educationList = "Education"
        case editEducation = "Edit Education"
        case editEmployment = "Edit Employment"
        case employmentList = "Employment"
        case personalInfo = "Personal"
        case menu = ""
        
        static func values() -> [(title: String, description: String)] {
            return [(PropertiesType.personalInfo.rawValue, ""), (PropertiesType.educationList.rawValue, ""), (PropertiesType.employmentList.rawValue, "")]
        }
    }
}

private extension EditResumeVC {

    func edit(resume: ResumeModel, exam: Exam) {
        guard let navigationController = navigationController as? CustomNavigationController else { return }
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        guard let modelExam = appDelegate.modelManager.modelFrom(exam: exam) else { return }
        let transitionHandler = TransitionHandler(navigationController: navigationController)
        appDelegate.isEditingCurrentResume = true
        // Issue with updating data in firebase.
        if let resumeData = appDelegate.currentResume {
            resumeData.uid = resume.uid!
            
            if let currentEmploymentModel = currentEmploymentModel {
                resumeData.currentEmployment = currentEmploymentModel
            } else if let currentEducationModel = currentEducationModel {
                resumeData.currentEducation = currentEducationModel
            }
        } else {
            print("WARNING: Possible Data Corruption")
        }
        
        transitionHandler.transitionTo(nextModelExam: modelExam, data: nil)
    }
    
    @objc func addModel() {
        guard let navigationController = navigationController as? CustomNavigationController else { return }
        let transitionHandler = TransitionHandler(navigationController: navigationController)
        if propertiesType == .employmentList {
            transitionHandler.createEmploymentModel()
        } else {
            print("")
        }
    }
    
    @objc func deleteModel() {
        guard let modelUID = whatModelUIDToDelete() else { return }
        guard let context = currentResumeModel.managedObjectContext else { return }
        guard let resumeUID = currentResumeModel.uid else { return }
        let firebaseService = FIRFirebaseService()
        
        if let model = whatModelToDelete() {
            firebaseService.delete(resumeID: resumeUID, employmentID: modelUID)
            context.delete(model)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func whatModelUIDToDelete() -> String? {
        switch propertiesType {
        case .editEmployment:
            return currentEmploymentModel?.uid
        case .editEducation:
            return currentEducationModel?.uid
        case .menu:
            return currentResumeModel.uid
        default:
             return nil
        }
    }
    func whatModelToDelete() -> NSManagedObject? {
        switch propertiesType {
        case .editEmployment:
            return currentEmploymentModel
        case .editEducation:
            return currentEducationModel
        case .menu:
            return currentResumeModel
        default:
            return nil
        }
    }
}

extension EditResumeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if propertiesType == .personalInfo {
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

        let newVC = EditResumeVC()
        
        newVC.currentResumeModel = currentResumeModel
        if let property = PropertiesType.init(rawValue: propertiesForCells[indexPath.row].title) {
            newVC.propertiesType = property
            
        } else {
            if propertiesType == .employmentList {
                let models = Array(currentResumeModel.employmentModels!)
                newVC.currentEmploymentModel = models[indexPath.row] as? EmploymentModel
                newVC.propertiesType = .editEmployment
            } else if propertiesType == .educationList {
                let models = Array(currentResumeModel.educationModels!)
                newVC.currentEducationModel = models[indexPath.row] as? EducationModel
                newVC.propertiesType = .editEducation
            }
        }
        
        navigationController?.pushViewController(newVC, animated: true)
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? EditResumeCell {
            let index = indexPath.row
            var titleText: String = ""
            
            if indexPath.section == 0 {
                let property = propertiesForCells[index]
                titleText = property.title
                
                if index < descriptionsForCells.count {
                    cell.describingLabel.text = property.description
                }
            }
            
            cell.titleLabel.text = "\(titleText)"
            
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return propertiesForCells.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let navigationController = navigationController else { return CGSize(width: 0.0, height: 0.0)}
        let navigationItemHeight = navigationController.navigationBar.frame.height
        return CGSize(width: view.frame.width, height: navigationItemHeight * 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
