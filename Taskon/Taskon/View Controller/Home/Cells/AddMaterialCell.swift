//
//  AddMaterialCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 22/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddMaterialCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var materialTextView: UITextView!
    @IBOutlet private weak var quantityField: SkyFloatingLabelTextField!
    @IBOutlet private weak var priceField: SkyFloatingLabelTextField!
    private var deleteAction: VoidCompletion? = nil
    private var textViewAction: TextCompletion? = nil
    private var quantityFieldAction: TextCompletion? = nil
    private var priceFieldAction: TextCompletion? = nil
    
    
    // MARK: - Initialization Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
        materialTextView.delegate = self
        quantityField.delegate = self
        priceField.delegate = self
        quantityField.textAlignment = .center
        priceField.textAlignment = .center
        materialTextView.font = .toFront(ofSize: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Action Methods
    
    @IBAction private func deleteButtonTapped(_ sender: UIButton) {
        deleteAction?()
    }
    
    
    // MARK: - Public Methods
    
    public func configure(material: TaskUsedMaterial,
                          for index: Int,
                          didChange action: @escaping TextCompletion,
                          quantity: @escaping TextCompletion,
                          price: @escaping TextCompletion,
                          deleteAction: @escaping VoidCompletion) {
        textViewAction = action
        quantityFieldAction = quantity
        priceFieldAction = price
        self.deleteAction = deleteAction
        
        titleLabel.text = "[\(index)] Material"
        materialTextView.text = material.title
        quantityField.text = material.quantity
        priceField.text = material.price
    }

}


// MARK: - TextView Methods

extension AddMaterialCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textViewAction?(textView.text)
    }
}


// MARK: - TextField Methods

extension AddMaterialCell: UITextFieldDelegate {
    
    func textFieldDidChange(_ textField: UITextField) {
        if textField == quantityField {
            quantityFieldAction?(textField.text ?? "")
        } else {
            priceFieldAction?(textField.text ?? "")
        }
    }
}
