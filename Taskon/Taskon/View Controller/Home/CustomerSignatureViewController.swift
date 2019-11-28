//
//  CustomerSignatureViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 28/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class CustomerSignatureViewController: AppViewController {
    
    
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

extension CustomerSignatureViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Customer"
    }
    
    private func setupViewController() {
        
    }
}


// MARK: - Action Methods
    
extension CustomerSignatureViewController {
    
}
