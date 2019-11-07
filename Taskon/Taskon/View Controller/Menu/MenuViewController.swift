//
//  MenuViewController.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class MenuViewController: AppTableViewController {

    
    // MARK: - Class Properties
    
    public var newTask: VoidCompletion? = nil
    public var syncData: VoidCompletion? = nil
    public var filter: FilterCompletion? = nil
    public var settings: VoidCompletion? = nil
    public var logout: VoidCompletion? = nil
    
    
    // MARK: - View Controller Life - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
}


// MARK: - TableView Methods

extension MenuViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            if let menu = MenuItem(rawValue: indexPath.row) {
                switch menu {
                case .newTask: self.newTask?()
                case .syncData: self.syncData?()
                case .filterByDistance: self.filter?(.distance)
                case .filterByDeadline: self.filter?(.deadLine)
                case .filterByDate: self.filter?(.date)
                case .settings: self.settings?()
                case .logout: self.logout?()
                    
                }
            }
        }
    }
    
}
