//
//  AddUserCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 22/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class AddUserCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var indexLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    private var deleteAction: VoidCompletion? = nil
    
    
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
    
    
    // MARK: - Action Methods
    
    @IBAction private func deleteButtonTapped(_ sender: UIButton) {
        deleteAction?()
    }
    
    
    // MARK: - Public Methods
    
    public func configure(user: TaskUsedMaterial, for index: Int, removeAction: VoidCompletion?) {
        deleteAction = removeAction
        indexLabel.text = "[\(index)] User"
        nameLabel.text = user.title
    }

}
