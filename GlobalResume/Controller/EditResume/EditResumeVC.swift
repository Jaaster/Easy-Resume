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
        return collectionView
    }()

    var isAddButtonAllowed: Bool {
        get {
            return propertiesType == .educationList || propertiesType == .employmentList
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
        }
    }
    
    func createAddButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addModel))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        let predicate = NSPredicate(format: "uid = %@", currentResumeModel.uid!)
//        currentResumeModel = resumeModelHandler.readModels(objectType: ResumeModel(), sortDescriptor: nil, predicate: predicate).first
        navigationController?.setNavigationBarHidden(false, animated: true)
        var indexPaths = [IndexPath]()
        
        for index in descriptionsForCells.indices {
            indexPaths.append(IndexPath(item: index, section: 0))
        }
        currentResumeModel.managedObjectContext?.refresh(currentResumeModel, mergeChanges: true)
        collectionView.reloadItems(at: indexPaths)
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
        let transportHandler = TransitionHandler(navigationController: navigationController)
        if propertiesType == .employmentList {
            // Create a new employment model
            transportHandler.addEmployment()
        } else {
            print("")
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

        let vc = EditResumeVC()
        
        vc.currentResumeModel = currentResumeModel
        if let property = PropertiesType.init(rawValue: propertiesForCells[indexPath.row].title) {
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
        
        return CGSize(width: view.frame.width, height: view.frame.height / CGFloat(propertiesForCells.count))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
