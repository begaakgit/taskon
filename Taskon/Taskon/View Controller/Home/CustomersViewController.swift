//
//  CustomersViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 15/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class CustomersViewController: AppTableViewController {
    
    
    // MARK: - Class Properties
    
    public var customers: [Customer] = []
    public var selectionBlock: CustomerCompletion? = nil
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension CustomersViewController {
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Customers"
    }
    
    private func setupViewController() {
        tableView.reloadData()
    }
}


// MARK: - Table View Methods
    
extension CustomersViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell", for: indexPath)
        
        let customer = customers[indexPath.row]
        cell.textLabel?.text = customer.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let customer = customers[indexPath.row]
        selectionBlock?(customer)
        pop(animated: true)
    }
}
