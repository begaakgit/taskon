//
//  ActionCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 20/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var firstView: UIView!
    @IBOutlet private weak var sencondView: UIView!
    @IBOutlet private weak var thirdView: UIView!
    @IBOutlet private weak var firstButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    @IBOutlet private weak var thirdButton: UIButton!
    
    
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
    
    @IBAction private func firstButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction private func secondButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction private func thirdButtonTapped(_ sender: UIButton) {
        
    }


}
