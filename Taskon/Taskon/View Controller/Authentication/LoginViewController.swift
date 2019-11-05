//
//  LoginViewController.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 06/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class LoginViewController: AppViewController {

    
    // MARK: - View Controller Life - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }

    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "TaskOn"
    }
    
    private func setupViewController() {
        
    }
}
