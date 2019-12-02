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
    case material(materials: [TaskUsedMaterial])
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
    public var taskId: Int!
    private var users: [StaticUser] = []
    private var materials: [TaskUsedMaterial] = []
    private var jobs: [Job] = []
    
    
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
        case .material(let materils):
            if self.materials.isEmpty {
                self.materials = materils
            }
            datasource = self.materials
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
        let material = TaskUsedMaterial(title: "", quantity: "0", price: "0", taskId: taskId)
        materials.append(material)
        if materials.count > 1 {
            let indexPath = IndexPath(row: materials.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else {
            self.updateUi()
        }
    }
    
    private func addJob() {
        let job = Job(description: "")
        jobs.append(job)
        if jobs.count > 1 {
            let indexPath = IndexPath(row: jobs.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else {
            self.updateUi()
        }
    }
    
    private func userCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: AddUserCell.self) else { return UITableViewCell() }
        let user = users[indexPath.row]
        cell.configure(user: user, for: indexPath.row + 1) { [weak self] in
            guard let self = self else { return }
            self.users.remove(at: indexPath.row)
            self.updateUi()
        }
        return cell
    }
    
    private func materialCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: AddMaterialCell.self) else { return UITableViewCell() }
        var material = materials[indexPath.row]
        
        let textviewChange: TextCompletion = { [weak self] text in
            guard let self = self else { return }
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            material.title = text
            self.materials.remove(at: indexPath.row)
            self.materials.insert(material, at: indexPath.row)
        }
        
        let quantityChange: TextCompletion = { [weak self] quantity in
            guard let self = self else { return }
            material.quantity = quantity
            self.materials.remove(at: indexPath.row)
            self.materials.insert(material, at: indexPath.row)
        }
        
        let priceChange: TextCompletion = { [weak self] price in
            guard let self = self else { return }
            material.price = price
            self.materials.remove(at: indexPath.row)
            self.materials.insert(material, at: indexPath.row)
        }
        
        let deleteAction: VoidCompletion = { [weak self] in
            guard let self = self else { return }
            self.materials.remove(at: indexPath.row)
            self.updateUi()
        }
        
        cell.configure(material: material,
                       for: indexPath.row + 1,
                       didChange: textviewChange,
                       quantity: quantityChange,
                       price: priceChange,
                       deleteAction: deleteAction)
        return cell
    }
    
    private func jobCell(for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: AddTaskCell.self) else { return UITableViewCell() }
        var job = jobs[indexPath.row]
        
        let textviewChange: TextCompletion = { [weak self] text in
            guard let self = self else { return }
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
            job.description = text
            self.jobs.remove(at: indexPath.row)
            self.jobs.insert(job, at: indexPath.row)
        }
        
        let deleteAction: VoidCompletion = { [weak self] in
            guard let self = self else { return }
            self.jobs.remove(at: indexPath.row)
            self.updateUi()
        }
        
        cell.configure(job: job,
                       for: indexPath.row + 1,
                       didChange: textviewChange,
                       deleteAction: deleteAction)
        return cell
    }
}


// MARK: - Action Methods
    
extension UpdateTaskViewController {
    
    @objc private func saveButtonTapped(_ sender: UIBarButtonItem) {
        view.isUserInteractionEnabled = false
        syncData(materials: materials) { [weak self] in
            guard let self = self else { return }
            self.view.isUserInteractionEnabled = true
            self.pop(animated: true)
        }
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
