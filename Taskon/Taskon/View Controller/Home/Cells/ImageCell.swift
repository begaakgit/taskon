//
//  ImageCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 20/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var taskImageView: UIImageView!
    @IBOutlet private weak var imageAddressLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    
    
    // MARK: - Initialization Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Action Methods
    
    @IBAction private func deleteButtonTapped(_ sender: UIButton) {
        
    }

}
