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
        button.backgroundColor = Color.blue.getUIColor()
        button.setTitle("KEEP", for: .normal)
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-Regular"))
        button.titleLabel?.font = font.withSize(20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(keepBtnPressed), for: UIControlEvents.touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let deleteBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Color.pink.getUIColor()
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-Regular"))
        button.titleLabel?.font = font.withSize(20)
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
        blurEffect()
        updateViews()
    }
  
    func blurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.frame = view.frame
        blurEffectView.alpha = 0.9
        view.addSubview(blurEffectView)
    }
    
    func updateViews() {
       
        let deleteBtnContainerView = CircleView()
        deleteBtnContainerView.round(scale: 5)
        deleteBtnContainerView.backgroundColor = .gray
        deleteBtnContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let keepBtnContainerView = CircleView()
        keepBtnContainerView.round(scale: 5)
        keepBtnContainerView.backgroundColor = .red
        keepBtnContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        keepBtnContainerView.addSubview(keepBtn)
        deleteBtnContainerView.addSubview(deleteBtn)
    
        keepBtn.topAnchor.constraint(equalTo: keepBtnContainerView.topAnchor).isActive = true
        keepBtn.bottomAnchor.constraint(equalTo: keepBtnContainerView.bottomAnchor).isActive = true
        keepBtn.leadingAnchor.constraint(equalTo: keepBtnContainerView.leadingAnchor).isActive = true
        keepBtn.trailingAnchor.constraint(equalTo: keepBtnContainerView.trailingAnchor).isActive = true
        
        
        deleteBtn.topAnchor.constraint(equalTo: deleteBtnContainerView.topAnchor).isActive = true
        deleteBtn.leadingAnchor.constraint(equalTo: deleteBtnContainerView.leadingAnchor).isActive = true
        deleteBtn.trailingAnchor.constraint(equalTo: deleteBtnContainerView.trailingAnchor).isActive = true
        deleteBtn.bottomAnchor.constraint(equalTo: deleteBtnContainerView.bottomAnchor).isActive = true
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(keepBtnContainerView)
        stackView.addArrangedSubview(deleteBtnContainerView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.80).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    
    @objc func swipedDown() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc func keepBtnPressed() {
        //Revert back to ChooseResumeVC
        dismiss(animated: true, completion: nil)
    }
    
    @objc func deleteBtnPressed() {
        //Delete
        PersistantService.context.delete(resume)
        PersistantService.saveContext()
        
        if let vc = presentingViewController as? ChooseResumeVC {
            if vc.resumes.isEmpty {
                vc.handleTransportation(forward: false)
                return
            }
            vc.collectionView?.reloadData()
        }
        dismiss(animated: true, completion: nil)
        
    }

}
