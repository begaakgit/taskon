//
//  AddMaterialViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 25/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class AddMaterialViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    public var addBlock: VoidCompletion? = nil
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension AddMaterialViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Add Material"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupViewController() {
        
    }
}


// MARK: - Action Methods
    
extension AddMaterialViewController {
    
}
