//
//  Button.swift
//  TestTaskForAlef
//
//  Created by Admin on 24.10.2022.
//

import UIKit
import SnapKit

final class CustomAddButton: UIButton {
    
    let colorBtn = UIColor(named: "ButtonColor")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor( colorBtn!.withAlphaComponent(0.8), for: .normal)
        layer.masksToBounds = true
        setTitle("Добавить ребенка", for: .normal)
        setImage(UIImage(systemName: "plus"), for: .normal)
        titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        translatesAutoresizingMaskIntoConstraints = false
        imageView!.image?.withTintColor(colorBtn!)
        titleLabel?.textAlignment = .center
        layer.borderWidth = 2
        layer.borderColor = colorBtn!.cgColor
        imageView?.tintColor = colorBtn
        titleLabel?.contentMode = .scaleToFill
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
           
        imageView?.snp.makeConstraints({
            $0.height.width.equalTo(22)
            $0.leading.equalTo(self).offset(10)
            $0.centerY.equalTo(self).offset(0)
        })
            
        titleLabel?.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide).offset(5)
            $0.leading.equalTo(imageView!.snp.trailing).offset(0)
            $0.trailing.equalTo(self).offset(-5)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-5)
        })
            
        layer.cornerRadius = frame.size.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
