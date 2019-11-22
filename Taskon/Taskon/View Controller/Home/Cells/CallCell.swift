//
//  CallCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 22/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class CallCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneImageView: UIImageView!
    @IBOutlet private weak var phoneLabel: UILabel!
    
    
    // MARK: - Initialization Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Public Methods
    
    public func configure(contact: Contact) {
        nameLabel.text = contact.name
        phoneImageView.image = #imageLiteral(resourceName: "phone")
        phoneLabel.text = contact.phone
    }

}
