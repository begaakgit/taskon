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
import SSSpinnerButton

class LoginViewController: AppViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var userTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var clientCodeTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var loginButton: SSSpinnerButton!
    
    private lazy var validator: Validator = Validator()
    
    
    // MARK: - View Controller Life - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
    deinit {
        debugPrint("DEINITsadasd")
    }

    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "TaskOn"
    }
    
    private func setupViewController() {
        userTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        clientCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        validator.registerField(textField: userTextField, rules: [RequiredRule()])
        validator.registerField(textField: passwordTextField, rules: [RequiredRule()])
        validator.registerField(textField: clientCodeTextField, rules: [RequiredRule()])
        validator.validate(delegate: self)
        loginButton.isEnabled = false
    }
    
    private func openHome() {
        let navController = Storyboard.home.instantiateInitialViewController() as? AppNavigationController
        view.window?.rootViewController = navController
    }
    
    private func startLoginSpin(completion: VoidCompletion? = nil) {
        loginButton.startAnimate(spinnerType: .ballRotateChase, spinnercolor: .white, complete: completion)
    }
    
    private func stopLoginSpin(type: CompletionType, completion: VoidCompletion? = nil) {
        loginButton.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: type, backToDefaults: true, complete: completion)
    }
    
}


// MARK: - Action Methods

extension LoginViewController {
    
    @IBAction private func loginButtonTapped(_ sender: UIButton) {
        loginButton.startAnimate(spinnerType: .ballRotateChase, spinnercolor: .white) { [weak self] in
            guard let self = self else { return }
            self.performClientRequest { [weak self] in
                guard let self = self else { return }
                self.performLoginRequest()
            }
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        validator.validate(delegate: self)
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
        loginButton.isEnabled = true
    }
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        loginButton.isEnabled = false
    }
    
}


// MARK: - API Request

extension LoginViewController {
    
    private func performClientRequest(completion: VoidCompletion? = nil) {
        guard let clientCode = clientCodeTextField.text else { return }
        let request = APIClient.login(company: clientCode.normalize)
        
        let success: ServiceSuccess<TOClient> = { [weak self] client in
            guard let self = self else { return }
            self.stopLoginSpin(type: .success) { [weak self] in
                guard let _ = self else { return }
                TOUserDefaults.client.set(value: client)
                completion?()
            }
        }
        
        let failure: ServiceFailure = { [weak self] _ in
            guard let self = self else { return }
            self.stopLoginSpin(type: .none)
        }
        
        request.execute(errorHandler: errorHandler, onFailure: failure, onSuccess: success)
    }
    
    private func performLoginRequest() {
        guard let username = userTextField.text,
            let password = passwordTextField.text else { return }
        let request = APIClient.login(username: username.normalize, password: password)
        
        let success: ServiceSuccess<User> = { [weak self] user in
            guard let self = self else { return }
            self.stopLoginSpin(type: .success) { [weak self] in
                guard let self = self else { return }
                debugPrint(user)
                self.openHome()
            }
        }
        
        let failure: ServiceFailure = { [weak self] _ in
            guard let self = self else { return }
            self.stopLoginSpin(type: .none)
        }
        
        request.execute(errorHandler: errorHandler, onFailure: failure, onSuccess: success)
    }
}
