//
//  ContactCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 20/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var arrowImageView: UIImageView!
    
    
    // MARK: - Initialization Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Public Methods
    
    public func configure(contact: Contact) {
        titleLabel.text = "Contacts"
        descriptionLabel.text = contact.name
        phoneLabel.text = contact.phone
    }

}
