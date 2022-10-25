//
//  ParentViewModel.swift
//  TestTaskForAlef
//
//  Created by Admin on 24.10.2022.
//

import Combine

final class ParentViewModel {
    
    @Published var childrens: Int = 0
    
    func deleteAction() {
        childrens = 0 
    }
    
    func addChildren() {
        childrens += 1
    }
    
}
