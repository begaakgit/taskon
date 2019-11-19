//
//  HomeCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SkeletonView

class HomeCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var subDescriptionLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    
    
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
    
    public func configure(task: Task?) {
        guard let task = task else {
            showAnimatedSkeleton()
            return
        }
        hideSkeletonAnimation()
        titleLabel.text = task.customerNamePrint
        distanceLabel.text = ""
        descriptionLabel.text = task.title
        dateLabel.text = task.dueTimestamp
        subDescriptionLabel.text = "\(task.nr), \(task.description)"
        statusLabel.text = task.status.getText()
    }
    
    
    // MARK: - Private  Methods
    
    public func showSkeletonAnimation() {
        let gradient = SkeletonGradient(baseColor: UIColor.asbestos)
        showGradientSkeleton(usingGradient: gradient, transition: .crossDissolve(0.0))
    }
    
    public func hideSkeletonAnimation() {
        hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.0))
    }

}
