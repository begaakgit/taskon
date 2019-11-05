//
//  AppNavigationController.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 05/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController {

    
    // MARK: - View Controller Life - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationBar.prefersLargeTitles = true
    }

}
