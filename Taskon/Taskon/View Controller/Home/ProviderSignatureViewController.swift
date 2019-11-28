//
//  ProviderSignatureViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 28/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ProviderSignatureViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension ProviderSignatureViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Provider"
    }
    
    private func setupViewController() {
        
    }
}


// MARK: - Action Methods
    
extension ProviderSignatureViewController {
    
}
