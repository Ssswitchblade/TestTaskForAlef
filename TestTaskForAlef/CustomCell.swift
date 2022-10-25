//
//  CustomCell.swift
//  TestTaskForAlef
//
//  Created by Admin on 25.10.2022.
//

import SnapKit
import UIKit
import Combine

class CustomTableViewCell: UITableViewCell {
    
    let color = UIColor(named: "ButtonColor")
    
    private(set) lazy var childNameTxtF = CustomTextField(labelText: "Имя", keybordStyle: .string)
    private(set) lazy var childAgeTxtF = CustomTextField(labelText: "Возраст", keybordStyle: .int)
    
    private(set) lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Удалить", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.setTitleColor(color, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        btn.addTarget(self, action: #selector(btnTpd), for: .touchUpInside)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(childNameTxtF)
        contentView.addSubview(childAgeTxtF)
        contentView.addSubview(deleteBtn)
        setupUI()
    }
    
    var index: IndexPath?
    
    var cancellable: AnyCancellable?
    let tapButton = PassthroughSubject<IndexPath?, Never>()
    
    @objc func btnTpd() {
        self.tapButton.send(index)
    }
    
    private func setupUI() {
        
        childNameTxtF.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide).offset(15)
            $0.leading.equalTo(self).offset(0)
            $0.trailing.equalTo(self).offset(-163)
        })
        
        childAgeTxtF.snp.makeConstraints({
            $0.top.equalTo(childNameTxtF.snp.bottom).offset(15)
            $0.leading.equalTo(self).offset(0)
            $0.trailing.equalTo(self).offset(-163)
        })
        
        deleteBtn.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide).offset(25)
            $0.leading.equalTo(childNameTxtF.snp.trailing).offset(15)
            $0.trailing.equalTo(self).offset(-45)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
     }
}
