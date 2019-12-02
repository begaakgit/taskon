//
//  AddTaskCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 22/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddTaskCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textview: UITextView!
    private var textViewAction: TextCompletion? = nil
    private var deleteAction: VoidCompletion? = nil
    
    
    // MARK: - Initialization Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
        textview.delegate = self
        textview.font = .toFront(ofSize: 14)
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
    
    public func configure(job: TaskUsedMaterial,
                          for index: Int,
                          didChange action: @escaping TextCompletion,
                          deleteAction: @escaping VoidCompletion) {
        textViewAction = action
        self.deleteAction = deleteAction
        
        titleLabel.text = "[\(index)] Job"
        textview.text = job.title
    }

}


// MARK: - TextView Methods

extension AddTaskCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textViewAction?(textView.text)
    }
}
