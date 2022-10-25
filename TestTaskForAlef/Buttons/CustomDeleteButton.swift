//
//  CustomDeleteButton.swift
//  TestTaskForAlef
//
//  Created by Admin on 25.10.2022.
//

import UIKit

final class CustomDeleteButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("Очистить", for: .normal)
        setTitleColor(UIColor.red.withAlphaComponent(0.8), for: .normal)
        layer.borderWidth = 1.2
        layer.borderColor = UIColor.red.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.size.height / 2
    }
}
