//
//  ResumeRightView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/4/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class ResumeRightView: UIView {
    
    var resume: ResumeData!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    func setupViews() {
        
        let email = customView(titleString: "Email:", infoString: "my email")
        let phone = customView(titleString: "Phone:", infoString: "2323234")
        let zip_code = customView(titleString: "Zip Code:", infoString: "233455")
        let gender = customView(titleString: "Gender:", infoString: "Male")
        
        var myViews = [email, phone, zip_code, gender]
        heightAnchor.constraint(equalToConstant: CGFloat(myViews.count) * 55 + 20).isActive = true
        
        var lastView: UIView = self
        
        for v in myViews {
            addSubview(v)
            if myViews.index(of: v) == 0 {
                v.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
                
            } else {
                v.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 20).isActive = true
            }
            
            v.leadingAnchor.constraint(equalTo: lastView.leadingAnchor).isActive = true
            v.trailingAnchor.constraint(equalTo: lastView.trailingAnchor).isActive = true
            v.heightAnchor.constraint(equalToConstant: 35).isActive = true
            lastView = v
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customView(titleString: String, infoString: String) -> UIView {
        
        let view = UIView()
        
        let title = UILabel()
        title.text = titleString
        title.textColor = .black
        title.font.withSize(15)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        
        let info = UILabel()
        info.text = infoString
        info.font.withSize(10)
        info.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(title)
        view.addSubview(info)
        
        
        title.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        title.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        info.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        info.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        info.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        info.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }
    
    
}

