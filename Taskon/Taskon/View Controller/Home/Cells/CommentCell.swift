//
//  CommentCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 21/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SkeletonView

class CommentCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var midSaperatorView: UIView!
    
    
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
    
    public func configure(comment: Comment?) {
        guard let comment = comment else {
            showSkeletonAnimation()
            return
        }
        hideSkeletonAnimation()
        nameLabel.text = comment.author
        dateLabel.text = comment.timestamp
        titleLabel.text = comment.message
    }
    
    
    // MARK: - Private  Methods
    
    public func showSkeletonAnimation() {
        midSaperatorView.alpha = 0.0
        let gradient = SkeletonGradient(baseColor: UIColor.silver)
        showGradientSkeleton(usingGradient: gradient, transition: .crossDissolve(0.0))
    }
    
    public func hideSkeletonAnimation() {
        midSaperatorView.alpha = 1.0
        hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.0))
    }

}
