//
//  ContactsViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 22/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class ContactsViewController: AppTableViewController {
    
    
    // MARK: - Class Properties
    
    public var contacts: [Contact] = []
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
    }
}


// MARK: - Private Methods

extension ContactsViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Contacts"
    }
    
    private func call(contact: Contact) {
        if let url = URL(string: "tel://\(contact.phone)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                showAlert(message: "You can not make calls.")
            }
        }
    }
}


// MARK: - Table View Methods
    
extension ContactsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: CallCell.self) else { return UITableViewCell() }
        
        let contact = contacts[indexPath.row]
        cell.configure(contact: contact)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let contact = contacts[indexPath.row]
        call(contact: contact)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
