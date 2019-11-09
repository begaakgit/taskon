//
//  NewTaskViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class NewTaskViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private weak var companyTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var tastTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var descriptiontextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var saveButton: UIButton!
    
    private lazy var validator: Validator = Validator()
    
    public var addTaskCompletion: VoidCompletion? = nil
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
}


// MARK: - Private Methods

extension NewTaskViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Register a new job"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupViewController() {
        companyTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tastTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        descriptiontextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        validator.registerField(textField: companyTextField, rules: [RequiredRule()])
        validator.registerField(textField: tastTextField, rules: [RequiredRule()])
        validator.registerField(textField: descriptiontextField, rules: [RequiredRule()])
        validator.validate(delegate: self)
        saveButton.isEnabled = false
    }
}


// MARK: - Action Methods
    
extension NewTaskViewController {
    
    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        performNewTaskRequest { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true) {
                self.addTaskCompletion?()
            }
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        validator.validate(delegate: self)
    }
    
}


// MARK: - TextField Delegate

extension NewTaskViewController: UITextFieldDelegate {
    
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

extension NewTaskViewController: ValidationDelegate {
    
    func validationSuccessful() {
        saveButton.isEnabled = true
    }
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        saveButton.isEnabled = false
    }
    
}


// MARK: - API Request

extension NewTaskViewController {
    
    private func performNewTaskRequest(completion: VoidCompletion? = nil) {
        guard let company = companyTextField.text,
            let task = tastTextField.text,
            let description = descriptiontextField.text else { return }
        completion?()
    }
    
}
