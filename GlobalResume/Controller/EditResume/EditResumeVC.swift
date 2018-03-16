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
    
    var propertiesType: PropertiesType! {
        willSet {
            if !newValue.rawValue.isEmpty {
                titleLabel.text = newValue.rawValue
            }
        }
    }
    
    var propertiesForCells: [String] {
        get {
            let staticButtons = [addButtonTitle, backButtonTitle]
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
            default :
                return []
            }
            
            return result + staticButtons
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
            case .contactInfo:
                result += Array(currentResumeModel.entity.attributesByName.keys).filter  { currentResumeModel.value(forKey: $0) != nil && $0 != "resumeName" }
            default :
                return []
            }
            return result.map({ (value) -> String in
                return value.titleCase
            })
        }
    }
    
    private let cellid = "editResumeCell"

    lazy var titleLabel: UILabel = {
        var label = UILabel()
        let font = UIFont.myFontRegular.withSize(35)
        label.textColor = color.myBlue
        label.font = font
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        return label
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .gray
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EditResumeCell.self, forCellWithReuseIdentifier: cellid)
        navigationController?.setNavigationBarHidden(true, animated: true)
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
        collectionView.reloadData()
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellTitle = propertiesForCells[indexPath.row]
        
        switch cellTitle {
        case addButtonTitle:
            
            break
        case backButtonTitle:
            //pop view
            navigationController?.popViewController(animated: true)
        default:
            //Push new viewcontroller
           
            if propertiesType == .contactInfo {
                let cellDescription = descriptionsForCells[indexPath.row]
                if let navigationController = self.navigationController as? CustomNavigationController {
                    if let exam = Exam(rawValue: cellDescription) {
                        if let model = navigationController.modelManager.modelFrom(exam: exam) {
                            let transitionHandler = TransitionHandler(navigationController: navigationController)
                            transitionHandler.transitionTo(nextModelExam: model, data: nil)
                            let resumeData = ResumeData()
                            resumeData.resumeName = currentResumeModel.resumeName!
                            navigationController.currentResume = resumeData
                        }
                    }
                }
            }
            
            
            
            let vc = EditResumeVC()
            
            vc.currentResumeModel = currentResumeModel
            if let property = PropertiesType.init(rawValue: propertiesForCells[indexPath.row]) {
                switch property {
                case .editEducation:
                    let models = Array(currentResumeModel.educationModels!)
                    vc.currentEducationModel = models[indexPath.row] as? EducationModel
                case .editEmployment:
                    let models = Array(currentResumeModel.employmentModels!)
                    vc.currentEmploymentModel = models[indexPath.row] as? EmploymentModel
                default :
                    break
                }
                vc.propertiesType = property
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as? EditResumeCell {
            let index = indexPath.row
            cell.titleLabel.text = propertiesForCells[index]
            if descriptionsForCells.count > index && index < propertiesForCells.count-1{
                cell.descriptingView.text = descriptionsForCells[index]
            }
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
        return CGSize(width: view.frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

