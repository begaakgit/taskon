//
//  NormalCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 20/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class NormalCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
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
    
    public func configure(title: String) {
        titleLabel.text = "Title"
        descriptionLabel.text = title
        arrowImageView.isHidden = true
    }
    
    public func configure(description: String) {
        titleLabel.text = "Description"
        descriptionLabel.text = description
        arrowImageView.isHidden = true
    }
    
    public func configureForComments() {
        titleLabel.text = "Comments"
        descriptionLabel.text = "View comments and add new ones"
        arrowImageView.isHidden = false
    }
    
    public func configure(address: String) {
        titleLabel.text = "Address"
        descriptionLabel.text = address
        arrowImageView.isHidden = false
    }
    
    public func configureForUsers() {
        titleLabel.text = "Users"
        descriptionLabel.text = "Add User"
        arrowImageView.isHidden = false
    }
    
    public func configureForMaterials() {
        titleLabel.text = "Materials"
        descriptionLabel.text = "Add Materials"
        arrowImageView.isHidden = false
    }
    
    public func configureForJobs() {
        titleLabel.text = "Jobs"
        descriptionLabel.text = "Add Jobs"
        arrowImageView.isHidden = false
    }

}
