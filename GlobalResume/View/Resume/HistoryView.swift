//
//  HistoryView.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 2/4/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class HistoryView: UIView {
    
    let place: UILabel = {
        let label = UILabel()
        label.text = "APPLE"
        label.font.withSize(15)
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let position: UILabel = {
        let label = UILabel()
        label.text = "DESIGNINER"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        return label
    }()
    
    let myDescription: UILabel = {
        let label = UILabel()
        label.text = "DJADIA DAND NDA DAM DD ia diad aiwdma ida dajd daw ai ir ir fsi f"
        label.backgroundColor = .gray
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let startAndEndDate: UILabel = {
        let label = UILabel()
        label.text = "32 - 32"
        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(place)
        place.addSubview(startAndEndDate)
        addSubview(position)
        addSubview(myDescription)
        setupViews()
    }
    
    
    func setupViews() {
        
        place.topAnchor.constraint(equalTo: topAnchor).isActive = true
        place.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        place.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        place.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        startAndEndDate.topAnchor.constraint(equalTo: place.topAnchor).isActive = true
        startAndEndDate.widthAnchor.constraint(equalToConstant: 100).isActive = true
        startAndEndDate.centerXAnchor.constraint(equalTo: place.centerXAnchor, constant: 20).isActive = true
        startAndEndDate.bottomAnchor.constraint(equalTo: place.bottomAnchor).isActive = true
        
        position.topAnchor.constraint(equalTo: place.bottomAnchor).isActive = true
        position.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        position.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        position.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        myDescription.topAnchor.constraint(equalTo: position.bottomAnchor).isActive = true
        myDescription.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        myDescription.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        myDescription.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    
}

