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
        return .lightContent
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .mainBlue
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        
        let buttonAppearance = UIBarButtonItemAppearance()
        buttonAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.white]
        appearance.buttonAppearance = buttonAppearance
        appearance.doneButtonAppearance = buttonAppearance
        appearance.backButtonAppearance = buttonAppearance
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .white
        navigationBar.prefersLargeTitles = true
    }

}
