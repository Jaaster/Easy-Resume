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
        let font = UIFont.crayon.withSize(25)

        label.textColor = .black
        label.font = font
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        return label
    }()
    
    
    
    let describingLabel: UILabel = {
        var label = UILabel()
        let font = UIFont.crayon.withSize(15)
        
        label.textColor = .gray
        label.font = font
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(describingLabel)
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
        
        describingLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        describingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        describingLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 0.50).isActive = true
        describingLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
