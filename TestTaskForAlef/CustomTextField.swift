//
//  CustomTextField.swift
//  TestTaskForAlef
//
//  Created by Admin on 24.10.2022.
//

import UIKit
import SnapKit

final class CustomTextField: UIView {
    
   private(set) lazy var textField: UITextField = {
       let field = UITextField()
       field.borderStyle = .none
       field.translatesAutoresizingMaskIntoConstraints = false
       field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
       field.leftViewMode = .always
       return field
    }()
    
    private lazy var label: UILabel = {
        var lbl = UILabel()
        lbl.text = ""
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.2
        lbl.textColor = .lightGray
        return lbl
    }()
    
    init(labelText: String, keybordStyle: KeybordStyle) {
        super.init(frame: .zero)
        self.label.text = labelText
        
        switch keybordStyle {
        case .int:
            textField.keyboardType = .numberPad
        case .string:
            textField.keyboardType = .default
        }
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(textField)
        addSubview(label)
        setupUI()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 9
    }
    
    private func setupUI() {
        
        label.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide).offset(5)
            $0.leading.equalTo(self).offset(5)
            $0.trailing.equalTo(self).offset(0)
        })
        
        textField.snp.makeConstraints({
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(self).offset(0)
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-5)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum KeybordStyle {
    case int
    case string
}
