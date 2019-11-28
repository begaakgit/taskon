//
//  AddUserViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 25/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class AddUserViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private weak var tableview: UITableView!
    public var addBlock: AddUser? = nil
    private var users: [StaticUser] = []
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension AddUserViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Users"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupViewController() {
        tableview.tableFooterView = UIView(frame: .zero)
        if let staticData = TOUserDefaults.staticData.get() {
            users = staticData.users
            tableview.reloadData()
        }
    }
}


// MARK: - Table View Methods
    
extension AddUserViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name + user.surname
        cell.textLabel?.font = .toFront(ofSize: 17)
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = users[indexPath.row]
        addBlock?(user)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
