//
//  TaskFinishedViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 28/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class TaskFinishedViewController: AppTableViewController {
    
    
    // MARK: - Class Properties
    
    public var location: Location!
    
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension TaskFinishedViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = location.title
    }
    
    private func setupViewController() {
        
    }
}


// MARK: - Action Methods
    
extension TaskFinishedViewController {
    
}
