//
//  AppTableViewController.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class AppTableViewController: UITableViewController {

    
    // MARK: - View Controller Life - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupViewController()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    
    // MARK: - Private Methods
    
    private func setupViewController() {
        tableView.tableFooterView = UIView(frame: .zero)
    }

}


// MARK: - Public Methods

extension AppTableViewController {
    
    public func showAlert(title: String = Constants.appTitle,
                          message: String,
                          okButtonTitle: String = "OK",
                          completion: VoidCompletion? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: okButtonTitle, style: .default) { [weak self] action in
            guard let _ = self else { return }
            completion?()
        }
        
        alertController.addAction(actionOk)
        alertController.preferredAction = actionOk
        present(alertController, animated: true, completion: nil)
    }
    
    public func performAnimation(_ animation: @escaping VoidCompletion) {
        UIView.animate(withDuration: 0.03, animations: animation) { [weak self] _ in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        }
    }
    
}
