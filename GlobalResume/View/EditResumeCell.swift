//
//  EditResumeCell.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/1/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit
class EditResumeCell: UICollectionViewCell {
    
    let titleView: UILabel = {
        var titleView = UILabel()
        titleView.textColor = UIColor.white
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-Regular"))
        titleView.font = font.withSize(25)
        titleView.text = "TEST"
        titleView.adjustsFontSizeToFitWidth = true
        titleView.textAlignment = .center
        titleView.isUserInteractionEnabled = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.backgroundColor = .clear
        return titleView
    }()
    
    let descriptingView: UITextView = {
        var textView = UITextView()
        textView.textColor = UIColor.white
        let font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.init(rawValue: "OpenSans-Regular"))
        textView.font = font.withSize(15)
        textView.isEditable = false
        textView.text = ""
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
        addSubview(descriptingView)
        updateViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateViews() {
        titleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        titleView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        descriptingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        descriptingView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        descriptingView.widthAnchor.constraint(equalTo: titleView.widthAnchor, multiplier: 0.50).isActive = true
        descriptingView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
