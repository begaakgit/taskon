//
//  TaskReportViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 28/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class TaskReportViewController: AppViewController {
    
    
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

extension TaskReportViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Report"
    }
    
    private func setupViewController() {
        
    }
}


// MARK: - Action Methods
    
extension TaskReportViewController {
    
    @IBAction private func providerButtonTapped(_ sender: UIButton) {
        let providerVC: ProviderSignatureViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        push(viewController: providerVC, animated: true)
    }
    
    @IBAction private func customerButtonTapped(_ sender: UIButton) {
        let customerVC: CustomerSignatureViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        push(viewController: customerVC, animated: true)
    }
    
    @IBAction private func continueButtonTapped(_ sender: UIButton) {
        
    }
}
