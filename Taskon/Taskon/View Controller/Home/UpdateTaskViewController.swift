//
//  UpdateTaskViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 22/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

enum UpdateTaskMode {
    case user
    case material
    case job
    
    public func title() -> String {
        switch self {
        case .user: return "Users"
        case .material: return "Materials"
        case .job: return "Jobs"
        }
    }
}

class UpdateTaskViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!
    public var mode: UpdateTaskMode = .user
    private var users: [StaticUser] = []
    private var materials: [String] = []
    private var jobs: [String] = []
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension UpdateTaskViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = mode.title()
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped(_:)))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func setupViewController() {
        tableView.tableFooterView = UIView(frame: .zero)
        addButton.setTitle("ADD \(mode.title().capitalized)", for: .normal)
        updateUi()
    }
    
    private func updateUi() {
        var datasource: [Any] = []
        
        switch mode {
        case .user: datasource = users
        case .material: datasource = materials
        case .job: datasource = jobs
        }
        
        tableView.reloadData()
        if datasource.isEmpty {
            tableView.setEmpty(text: Constants.Messages.noResult)
        } else {
            tableView.resetEmptyText()
        }
    }
    
    private func addUser() {
        let addUserVC: AddUserViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        addUserVC.addBlock = { [weak self] user in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
            self.users.append(user)
            self.updateUi()
        }
        let navController = AppNavigationController(rootViewController: addUserVC)
        present(navController, animated: true, completion: nil)
    }
    
    private func addMaterial() {
        let addMaterialVC: AddMaterialViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        addMaterialVC.addBlock = { [weak self] in
            guard let _ = self else { return }
        }
        let navController = AppNavigationController(rootViewController: addMaterialVC)
        present(navController, animated: true, completion: nil)
    }
    
    private func addJob() {
        let addJobVC: AddJobViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        addJobVC.addBlock = { [weak self] in
            guard let _ = self else { return }
        }
        let navController = AppNavigationController(rootViewController: addJobVC)
        present(navController, animated: true, completion: nil)
    }
    
    private func userCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: AddUserCell.self) else { return UITableViewCell() }
        let user = users[indexPath.row]
        cell.configure(user: user, for: indexPath.row + 1) { [weak self] in
            guard let self = self else { return }
            self.users.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        return cell
    }
    
    private func materialCell(for indexPAth: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    private func jobCell(for indexPAth: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


// MARK: - Action Methods
    
extension UpdateTaskViewController {
    
    @objc private func saveButtonTapped(_ sender: UIBarButtonItem) {
        pop(animated: true)
    }
    
    @IBAction private func addBUttonTapped(_ sender: UIButton) {
        switch mode {
        case .user: addUser()
        case .material: addMaterial()
        case .job: addJob()
        }
    }
}


// MARK: - Table View Methods

extension UpdateTaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mode {
        case .user:  return users.count
        case .material: return materials.count
        case .job: return jobs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch mode {
        case .user:  return userCell(for: indexPath)
        case .material: return materialCell(for: indexPath)
        case .job: return jobCell(for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
