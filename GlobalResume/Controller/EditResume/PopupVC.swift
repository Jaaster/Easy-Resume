//
//  PopupVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/4/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class PopupVC: UIViewController {
    
    var resume: ResumeData!
    
    let keepBtn: UIButton = {
        let button = UIButton(type: .system)
        let font = UIFont.myFontRegular.withSize(20)
        
        button.backgroundColor = UIColor.myBlue
        button.setTitle("KEEP", for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(keepBtnPressed), for: UIControlEvents.touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let deleteBtn: UIButton = {
        let button = UIButton(type: .system)
        let font = UIFont.myFontRegular.withSize(20)
        
        button.backgroundColor = UIColor.myRed
        button.titleLabel?.font = font
        button.setTitle("DELETE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(deleteBtnPressed), for: UIControlEvents.touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        view.backgroundColor = .clear
        view.isOpaque = false
        modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let down = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        down.direction = .down
        view.addGestureRecognizer(down)
        addBlurEffect()
        updateViews()
    }
  
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = view.frame
        blurEffectView.alpha = 0.9
        view.addSubview(blurEffectView)
    }
    
    func updateViews() {
        let stackView = UIStackView()
        let keepBtnContainerView = createContainer()
        let deleteBtnContainerView = createContainer()
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(keepBtnContainerView)
        stackView.addArrangedSubview(deleteBtnContainerView)
        keepBtnContainerView.addSubview(keepBtn)
        deleteBtnContainerView.addSubview(deleteBtn)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        keepBtn.topAnchor.constraint(equalTo: keepBtnContainerView.topAnchor).isActive = true
        keepBtn.bottomAnchor.constraint(equalTo: keepBtnContainerView.bottomAnchor).isActive = true
        keepBtn.leadingAnchor.constraint(equalTo: keepBtnContainerView.leadingAnchor).isActive = true
        keepBtn.trailingAnchor.constraint(equalTo: keepBtnContainerView.trailingAnchor).isActive = true
        
        deleteBtn.topAnchor.constraint(equalTo: deleteBtnContainerView.topAnchor).isActive = true
        deleteBtn.leadingAnchor.constraint(equalTo: deleteBtnContainerView.leadingAnchor).isActive = true
        deleteBtn.trailingAnchor.constraint(equalTo: deleteBtnContainerView.trailingAnchor).isActive = true
        deleteBtn.bottomAnchor.constraint(equalTo: deleteBtnContainerView.bottomAnchor).isActive = true
        
       
    }
    
    private func createContainer() -> CircleView {
        let containerView = CircleView()
        containerView.round(scale: 5)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }
    
    @objc func swipedDown() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keepBtnPressed() {
        //Revert back to ChooseResumeVC
        dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteBtnPressed() {
        PersistantService.context.delete(resume)
        PersistantService.saveContext()
        
        if let vc = presentingViewController as? ChooseResumeVC {
            if vc.resumes.isEmpty {
                vc.present(forward: false)
                return
            }
            vc.collectionView?.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
}
