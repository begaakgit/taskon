//
//  LoginViewController.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 06/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class LoginViewController: AppViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var userTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var clientCodeTextField: SkyFloatingLabelTextField!
    
    private lazy var validator: Validator = Validator()
    
    
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
        validator.registerField(textField: userTextField, rules: [RequiredRule()])
        validator.registerField(textField: passwordTextField, rules: [RequiredRule()])
        validator.registerField(textField: clientCodeTextField, rules: [RequiredRule()])
        validator.validate(delegate: self)
    }
    
}


// MARK: - Action Methods

extension LoginViewController {
    
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        
        let clientCode = clientCodeTextField.text!
        let request = APIClient.login(company: clientCode)
        request.execute(errorHandler: errorHandler) { [weak self] client in
            guard let self = self else { return }
            TOUserDefaults.client.set(value: client)
        }
        
    }
    
}

// MARK: - TextField Delegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let next = view.viewWithTag(textField.tag + 1) {
            next.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return false
    }
    
}


// MARK: - ValidationDelegate Methods

extension LoginViewController: ValidationDelegate {
    
    func validationSuccessful() {
        
    }
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        
    }
    
}
