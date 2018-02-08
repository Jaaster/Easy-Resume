//
//  EditResumeCell.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/1/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class EditResumeCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        var label = UILabel()
        let font = UIFont.myFontRegular.withSize(25)

        label.textColor = UIColor.white
        label.font = font
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    let descriptingView: UITextView = {
        var textView = UITextView()
        let font = UIFont.myFontRegular.withSize(15)
        
        textView.textColor = UIColor.white
        textView.font = font
        textView.isEditable = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        backgroundColor = UIColor.myBlue
        addSubview(titleLabel)
        addSubview(descriptingView)
        updateViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateViews() {
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 38).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        descriptingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptingView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 0.50).isActive = true
        descriptingView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
