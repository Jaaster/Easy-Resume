////
////  ChooseResumeVC.swift
////  GlobalResume
////
////  Created by Joriah Lasater on 2/1/18.
////  Copyright © 2018 Joriah Lasater. All rights reserved.
////
//
import UIKit

class ResumesVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
     var resumes: [ResumeModel]!
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = UIImage(named: "TableBackground")
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setToolbarHidden(true, animated: true)
        
        setupViews()
        collectionView?.register(ResumeCell.self, forCellWithReuseIdentifier: "ResumeCell")
        collectionView?.bounces = true
        collectionView?.isPagingEnabled = true
        print(resumes)
        
        let resumeHandler = ResumeModelHandler()
        resumes = resumeHandler.readResumeModels(sortDescriptor: nil, predicate: nil)
    }

    func addSubviews() {
        collectionView?.backgroundView = bgImageView
    }
    
    func setupViews() {
        addSubviews()
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResumeCell", for: indexPath) as? ResumeCell {
            cell.titleLabel.text = resumes[indexPath.row].resumeName
            return cell
        }
        return UICollectionViewCell()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resumes.count
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Present Editor for that specific Resume
    }
}

class ResumeCell: UICollectionViewCell {
    let paperImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Papers")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.bounds = CGRect(x: 0, y: 0, width: frame.width, height: 50)
        label.font = UIFont.crayon.withSize(30)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(paperImage)
        addSubview(titleLabel)
        
        
        paperImage.anchor(safeAreaLayoutGuide.topAnchor, left: leadingAnchor, bottom: nil, right: trailingAnchor, topConstant: frame.height/7, leftConstant: 20, bottomConsant: 0, rightConstant: -20, widthConstant: 0, heightConstant: 300)
        
        titleLabel.anchor(paperImage.centerYAnchor, left: paperImage.leadingAnchor, bottom: nil, right: paperImage.trailingAnchor, topConstant: -40, leftConstant: 20, bottomConsant: 0, rightConstant: -30, widthConstant: 0, heightConstant: 80)
    }
    
}
