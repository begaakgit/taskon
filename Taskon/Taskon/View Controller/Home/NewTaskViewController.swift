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
    @IBOutlet private weak var lookupButton: LoadingButton!
    @IBOutlet private weak var saveButton: UIButton!
    
    private lazy var validator: Validator = Validator()
    
    public var addTaskCompletion: VoidCompletion? = nil
    
    private var customers: [Customer] = []
    private var selectedCustomer: Customer? = nil
    
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
        saveButton.enable = false
    }
    
    private func openCustomers() {
        if !customers.isEmpty {
            let customersVC: CustomersViewController = instanceFromStoryboard(storyboard: Storyboard.home)
            customersVC.customers = customers
            
            customersVC.selectionBlock = { [weak self] customer in
                guard let self = self else { return }
                self.selectedCustomer = customer
                self.companyTextField.text = customer.name
            }
            
            push(viewController: customersVC, animated: true)
        }
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
    
    @IBAction private func lookupButtonTapped(_ sender: UIButton) {
        lookupButton.startLoading()
        view.endEditing(true)
        view.isUserInteractionEnabled = false
        performGetCustomerRequest { [weak self] in
            guard let self = self else { return }
            self.lookupButton.endLoading()
            self.view.isUserInteractionEnabled = true
            self.openCustomers()
        }
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
        saveButton.enable = true
    }
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        saveButton.enable = false
    }
    
}


// MARK: - API Request

extension NewTaskViewController {
    
    private func performNewTaskRequest(completion: VoidCompletion? = nil) {
        guard let task = tastTextField.text,
            let description = descriptiontextField.text else { return }
        
        let customerName = selectedCustomer?.name ?? companyTextField.text ?? ""
        let customerId = selectedCustomer?.id
        let request = APIClient.newTask(title: task, description: description, customerId: customerId, customerName: customerName)
        
        let success: ServiceSuccess<EmptyCodable> = { [weak self] _ in
            guard let self = self else { return }
            completion?()
        }
        
        request.execute(errorHandler: errorHandler, onSuccess: success)
    }
    
    private func performGetCustomerRequest(completion: VoidCompletion? = nil) {
        let searchText = companyTextField.text ?? ""
        let request = APIClient.customers(search: searchText)
        
        let success: ServiceSuccess<CustomerResponse> = { [weak self] response in
            guard let self = self else { return }
            self.customers.removeAll()
            self.customers = response.customers
            completion?()
        }
        
        let failure: ServiceFailure = { [weak self] _ in
            guard let self = self else { return }
            self.lookupButton.endLoading()
        }
        
        request.execute(errorHandler: errorHandler, onFailure: failure, onSuccess: success)
    }
    
}
