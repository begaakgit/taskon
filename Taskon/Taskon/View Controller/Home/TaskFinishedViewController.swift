//
//  TaskFinishedViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 28/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SimpleCheckbox

class TaskFinishedViewController: AppTableViewController {
    
    
    // MARK: - Class Properties
    
    public var location: Location!
    @IBOutlet private weak var firstCheckBox: Checkbox!
    @IBOutlet private weak var secondCheckBox: Checkbox!
    
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension TaskFinishedViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = location.title
        let continueButton = UIBarButtonItem(title: "Continue", style: .done, target: self, action: #selector(continueButtontapped(_:)))
        navigationItem.rightBarButtonItem = continueButton
    }
    
    private func setupViewController() {
        firstCheckBox.borderCornerRadius = 3.0
        firstCheckBox.borderLineWidth = 2.0
        firstCheckBox.borderStyle = .square
        firstCheckBox.checkmarkStyle = .tick
        firstCheckBox.checkmarkColor = .mainBlue
        firstCheckBox.checkmarkSize = 0.75
        firstCheckBox.isChecked = false
        
        secondCheckBox.borderCornerRadius = 3.0
        secondCheckBox.borderLineWidth = 2.0
        secondCheckBox.borderStyle = .square
        secondCheckBox.checkmarkStyle = .tick
        secondCheckBox.checkmarkColor = .mainBlue
        secondCheckBox.checkmarkSize = 0.75
        secondCheckBox.isChecked = false
    }
}


// MARK: - Action Methods

extension TaskFinishedViewController {
    
    @objc private func continueButtontapped(_ sender: UIBarButtonItem) {
        
    }
}


// MARK: - Table View Methods
    
extension TaskFinishedViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        
        let label = UILabel(frame: .zero)
        label.font = .toFront(ofSize: 20, type: .bold)
        if section == 0 {
            label.text = "Result"
        } else if section == 1 {
            label.text = "Pricing"
        } else {
            label.text = "Form a document"
        }
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.top.equalTo(8)
        }
        
        let lineView = UIView(frame: .zero)
        lineView.backgroundColor = .mainBlue
        view.addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.bottom.equalTo(0)
            $0.height.equalTo(2)
        }
        
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 65
        }
    }
}
