//
//  PickMileRangeVC.swift
//  GlobalResume
//
//  Created by Joriah Lasater on 5/1/18.
//  Copyright © 2018 Joriah Lasater. All rights reserved.
//

import UIKit

class PickMileRangeVC: UIViewController {
    
    let maxValue: Float = 100
    let minValue: Float = 0
    let defaultValue: Float = 10
    
    private lazy var sliderView: UISlider = {
        let sliderFrame = CGRect(origin: view.center, size: CGSize(width: view.frame.width/4*3, height: 100))
        let uiSlider = UISlider(frame: sliderFrame)
        uiSlider.center = view.center
        uiSlider.maximumValue = maxValue
        uiSlider.minimumValue = minValue
        uiSlider.value = defaultValue
        return uiSlider
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.text = "Miles Radius"
        label.textAlignment = .center
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.text = "3.0"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        setupViews()
        sliderView.addTarget(self, action: #selector(slider), for: .valueChanged)
        
    }
    
    @objc func slider() {
        valueLabel.text = "\(Int(sliderView.value))"
    }
    
    private func setupViews() {
        view.addSubview(sliderView)
        view.addSubview(titleLabel)
        view.addSubview(valueLabel)
        view.backgroundColor = .white
        
        let center = view.center
        let spacing: CGFloat = 40
        let titleLabelCenter = center.subtract(x: 0, y: spacing)
        let valueLabelCenter = center.add(x: 0, y: spacing)
        
        titleLabel.center = titleLabelCenter
        valueLabel.center = valueLabelCenter
        
    }
}
