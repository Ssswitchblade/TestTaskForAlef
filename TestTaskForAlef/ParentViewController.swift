//
//  ViewController.swift
//  TestTaskForAlef
//
//  Created by Admin on 24.10.2022.
//

import UIKit
import Combine

class ParentViewController: UIViewController {

    let viewModel: ParentViewModel
    private lazy var  parentView = self.view as? ParentView
    var canceballe = Set<AnyCancellable>()
    var childrens: Int?
    
    
    init(viewModel: ParentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.$childrens
            .sink(receiveValue: { [weak self] value in
                self?.childrens = value
            }).store(in: &canceballe)
    }
    
    
    override func loadView() {
        super.loadView()
        let view = ParentView(viewModel: viewModel)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        setupBindings()
    }

    private func setupBindings() {
        
        parentView?.addChildBtn.tapPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.viewModel.addChildren()
            }).store(in: &canceballe)
        
        viewModel.$childrens
            .map({$0 >= 5 })
            .sink(receiveValue: { [weak self] value in
                self?.parentView?.addChildBtn.isHidden = value
            }).store(in: &canceballe)
        
        parentView?.deleteBtn.tapPublisher
            .sink(receiveValue: { [weak self] _ in
                self?.parentView?.setupAlert()
                self?.present((self?.parentView!.alert)!, animated: true)
            }).store(in: &canceballe)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ParentViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ParentViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
