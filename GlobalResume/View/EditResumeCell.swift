//
//  EditResumeCell.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/1/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class EditResumeCell: UICollectionViewCell {
    
    let titleView: UITextView = {
        var textView = UITextView()
        textView.textColor = UIColor.white
        textView.font = UIFont.boldSystemFont(ofSize: 32)
        textView.isEditable = false
        textView.text = "TEST"
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.blue.getUIColor()
        addSubview(titleView)
        
        updateViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateViews() {
        titleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70).isActive = true
        titleView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.80).isActive = true
    }
}
