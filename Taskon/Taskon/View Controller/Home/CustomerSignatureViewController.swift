//
//  CustomerSignatureViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 28/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftSignatureView
import SwiftValidator

class CustomerSignatureViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private weak var firstTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var secondTextField: SkyFloatingLabelTextField!
    @IBOutlet private weak var signatureView: SwiftSignatureView!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    private lazy var validator: Validator = Validator()
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension CustomerSignatureViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Customer"
    }
    
    private func setupViewController() {
        firstTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        validator.registerField(textField: secondTextField, rules: [RequiredRule()])
        validator.validate(delegate: self)
        
        saveButton.enable = false
        deleteButton.enable = false
        
        signatureView.delegate = self
        signatureView.minimumStrokeWidth = 2.0
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        validator.validate(delegate: self)
        deleteButton.isEnabled = true
        
    }
}


// MARK: - ValidationDelegate Methods

extension CustomerSignatureViewController: ValidationDelegate {
    
    func validationSuccessful() {
        if let _ = signatureView.signature {
            saveButton.enable = true
        } else {
            saveButton.enable = false
        }
        deleteButton.enable = true
    }
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        saveButton.enable = false
        deleteButton.enable = true
    }
    
}


// MARK: - SwiftSignatureView Methods

extension CustomerSignatureViewController: SwiftSignatureViewDelegate {
    
    func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {
        validator.validate(delegate: self)
        deleteButton.enable = true
    }
    
    func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView, _ pan: UIPanGestureRecognizer) {
        validator.validate(delegate: self)
        deleteButton.enable = true
    }
    
}


// MARK: - Action Methods
    
extension CustomerSignatureViewController {
    
    @IBAction private func saveButtonTapped(_ sender: UIButton) {
        pop(animated: true)
    }
    
    @IBAction private func deleteButtonTapped(_ sender: UIButton) {
        firstTextField.text = "-"
        secondTextField.text = nil
        secondTextField.placeholder = "Enter surname (mandatory field)"
        signatureView.clear()
    }
}
