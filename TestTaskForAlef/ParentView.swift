//
//  ParentView.swift
//  TestTaskForAlef
//
//  Created by Admin on 24.10.2022.
//

import UIKit
import SnapKit
import Combine

final class ParentView: UIView {
    
    private lazy var personalLbl: UILabel = {
        var lbl = UILabel()
        lbl.text = "Персональные данные"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    private lazy var childLbl: UILabel = {
        var lbl = UILabel()
        lbl.text = "Дети (макс.5)"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    private(set) lazy var parentNameField = CustomTextField(labelText: "Имя", keybordStyle: .string)
    
    private(set) lazy var parentAgeField = CustomTextField(labelText: "Возраст", keybordStyle: .int)
    
    private(set) lazy var addChildBtn = CustomAddButton()
     
    private(set) lazy var deleteBtn = CustomDeleteButton()
     
    private(set) lazy var tableView: UITableView = {
         let table = UITableView()
         table.translatesAutoresizingMaskIntoConstraints = false
         table.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
         table.separatorStyle = .singleLine
         table.allowsSelection = false 
         return table
     }()
    
     private(set) lazy var alert = UIAlertController()
     
     let viewModel: ParentViewModel
     var childrens: Int?
     var canceballe = Set<AnyCancellable>()
      
     init(viewModel: ParentViewModel) {
         self.viewModel = viewModel
         super.init(frame: .zero)
          
          viewModel.$childrens
              .sink(receiveValue: { [weak self] value in
                  self?.childrens = value
                   self?.tableView.reloadData()
              }).store(in: &canceballe)
          
         backgroundColor = .white
         
         addSubview(personalLbl)
         addSubview(parentNameField)
         addSubview(parentAgeField)
         addSubview(childLbl)
         addSubview(addChildBtn)
         addSubview(tableView)
         addSubview(deleteBtn)
         setupUI()
         tableView.dataSource = self
         tableView.delegate = self
     }
     
     func setupAlert() {
          alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
          let actionDelete = UIAlertAction(title: "Сбросить данные", style: .default, handler: { _ in
               self.viewModel.deleteAction()
              self.tableView.reloadData()
          })
          let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
          alert.addAction(cancelAction)
          alert.addAction(actionDelete)
     }
     
     private func setupUI() {
        
        personalLbl.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(self).offset(22)
            $0.trailing.equalTo(self).offset(-22)
        })
        
        parentNameField.snp.makeConstraints({
            $0.top.equalTo(personalLbl.snp.bottom).offset(12)
            $0.leading.equalTo(self).offset(22)
            $0.trailing.equalTo(self).offset(-22)
        })
        
        parentAgeField.snp.makeConstraints({
            $0.top.equalTo(parentNameField.snp.bottom).offset(12)
            $0.leading.equalTo(self).offset(22)
            $0.trailing.equalTo(self).offset(-22)
        })
        
        childLbl.snp.makeConstraints({
            $0.top.equalTo(parentAgeField.snp.bottom).offset(20)
            $0.leading.equalTo(self).offset(22)
            $0.trailing.equalTo(self).offset(-220)
        })
        
        addChildBtn.snp.makeConstraints({
            $0.top.equalTo(parentAgeField.snp.bottom).offset(12)
            $0.leading.equalTo(childLbl.snp.trailing).offset(6)
            $0.trailing.equalTo(self).offset(-22)
            $0.height.equalTo(45)
        })
         
         tableView.snp.makeConstraints({
              $0.top.equalTo(addChildBtn.snp.bottom).offset(5)
              $0.leading.equalTo(self).offset(22)
              $0.trailing.equalTo(self).offset(-22)
              $0.bottom.equalTo(safeAreaLayoutGuide).offset(-72)
         })
         
         deleteBtn.snp.makeConstraints({
              $0.top.equalTo(tableView.snp.bottom).offset(15)
              $0.centerX.equalTo(self)
              $0.height.equalTo(42)
              $0.width.equalTo(196)
              $0.bottom.equalTo(safeAreaLayoutGuide).offset(-15)
         })
         
         deleteBtn.layer.cornerRadius = deleteBtn.bounds.size.height / 2
         print(deleteBtn.frame.size.height / 2)
    }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}

extension ParentView: UITableViewDelegate {
     
     public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return childrens ?? 0
     }

     public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 155
     }
}

extension ParentView: UITableViewDataSource {

     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell
          cell?.index = indexPath
          cell?.cancellable = cell?.tapButton .sink(receiveValue: { index in
               self.childrens? -= 1
               self.tableView.deleteRows(at: [index!], with: .automatic)
               self.tableView.reloadData()
               self.viewModel.childrens -= 1
          })
          return cell!
     }
}
