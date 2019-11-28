//
//  ActionCell.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 20/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

protocol ActionCellDelegate: class {
    func cameraButtonTapped()
    func acceptTaskTapped()
    func startTaskTapped()
    func stopTaskTapped()
    func finishTaskTapped()
}

class ActionCell: UITableViewCell, Registerable {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var firstView: UIView!
    @IBOutlet private weak var sencondView: UIView!
    @IBOutlet private weak var thirdView: UIView!
    @IBOutlet private weak var firstButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    @IBOutlet private weak var thirdButton: UIButton!
    public weak var delegate: ActionCellDelegate? = nil
    
    
    // MARK: - Initialization Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        firstButton.titleLabel?.font = .toFront(ofSize: 17, type: .bold)
        thirdButton.titleLabel?.font = .toFront(ofSize: 17, type: .bold)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - Action Methods
    
    @IBAction private func firstButtonTapped(_ sender: UIButton) {
        buttontapped(sender)
    }
    
    @IBAction private func secondButtonTapped(_ sender: UIButton) {
        delegate?.cameraButtonTapped()
    }
    
    @IBAction private func thirdButtonTapped(_ sender: UIButton) {
        buttontapped(sender)
    }
    
    
    // MARK: - Private Methods
    
    private func buttontapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        switch title {
        case "ACCEPT": delegate?.acceptTaskTapped()
        case "START": delegate?.startTaskTapped()
        case "FINISH": delegate?.finishTaskTapped()
        case "PAUSE": delegate?.stopTaskTapped()
        default: break
        }
    }
    
    
    // MARK: - Public Methods
    
    public func configure(for state: TaskDetailState) {
        switch state {
        case .registered:
            firstView.isHidden = false
            firstButton.setTitle("ACCEPT", for: .normal)
            sencondView.isHidden = false
            secondButton.setTitle("", for: .normal)
            secondButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
            thirdView.isHidden = true
            
        case .approved:
            firstView.isHidden = false
            firstButton.setTitle("START", for: .normal)
            sencondView.isHidden = false
            secondButton.setTitle("", for: .normal)
            secondButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
            thirdView.isHidden = true
            
        case .inProgress:
            firstView.isHidden = false
            firstButton.setTitle("FINISH", for: .normal)
            sencondView.isHidden = false
            secondButton.setTitle("", for: .normal)
            secondButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
            thirdView.isHidden = false
            thirdButton.setTitle("PAUSE", for: .normal)
            
        case .notFinished:
            firstView.isHidden = false
            firstButton.setTitle("START", for: .normal)
            sencondView.isHidden = false
            secondButton.setTitle("", for: .normal)
            secondButton.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
            thirdView.isHidden = true
        }
    }


}
