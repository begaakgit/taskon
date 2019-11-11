//
//  HomeViewController.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

class HomeViewController: AppViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var menuButton: UIBarButtonItem!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - View Controller Life - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Home"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupViewController() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func addNewTask() -> VoidCompletion {
        let addNewTask = { [weak self] in
            guard let self = self else { return }
            self.createNewTask()
        }
        return addNewTask
    }
    
    private func syncData() -> VoidCompletion {
        let syncNewData = { [weak self] in
            guard let _ = self else { return }
        }
        return syncNewData
    }
    
    private func applyFilter() -> FilterCompletion {
        let applyFilter: FilterCompletion = { [weak self] filter in
            guard let self = self else { return }
            switch filter {
            case .distance: break
            case .deadLine: break
            case .date: self.selectDate()
            }
        }
        return applyFilter
    }
    
    private func openSettings() -> VoidCompletion {
        let settings = { [weak self] in
            guard let self = self else { return }
            self.showSettings()
        }
        return settings
    }
    
    private func performLogout() -> VoidCompletion {
        let logout = { [weak self] in
            guard let self = self else { return }
            self.performLogoutRequest()
        }
        return logout
    }

}


// MARK: - Navigation Methods

extension HomeViewController {
    
    private func createNewTask() {
        let createVC: NewTaskViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        createVC.addTaskCompletion = { [weak self] in
            guard let _ = self else { return }
        }
        let navController = AppNavigationController(rootViewController: createVC)
        present(navController, animated: true, completion: nil)
    }
    
    private func selectDate() {
        let datePickerVC: DatePickerViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        datePickerVC.datePickerCompletion = { [weak self] date in
            guard let _ = self else { return }
            debugPrint(date)
        }
        let navController = AppNavigationController(rootViewController: datePickerVC)
        present(navController, animated: true, completion: nil)
    }
    
    private func showSettings() {
        let settingsVC: SettingsViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        let navController = AppNavigationController(rootViewController: settingsVC)
        present(navController, animated: true, completion: nil)
    }
}


// MARK: - Action Methods

extension HomeViewController {
    
    @IBAction private func menuButtonTapped(_ sender: UIBarButtonItem) {
        guard let menuVC = Storyboard.menu.instantiateInitialViewController() as? MenuViewController else { return }
        menuVC.newTask = addNewTask()
        menuVC.syncData = syncData()
        menuVC.filter = applyFilter()
        menuVC.settings = openSettings()
        menuVC.logout = performLogout()
        menuVC.modalPresentationStyle = .popover
        menuVC.preferredContentSize = CGSize(width: 250, height: 430)
        guard let popOver = menuVC.popoverPresentationController else { return }
        popOver.delegate = self
        popOver.barButtonItem = sender
        present(menuVC, animated: true, completion: nil)
    }
}


// MARK: - PopOver Presentation Methods

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}


// MARK: - TableView Methods

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: HomeCell.self) else { return UITableViewCell() }
        return cell
    }
    
}


// MARK: - API Request

extension HomeViewController {
    
    private func performLogoutRequest() {
//        let request = APIClient.login(company: clientCode.normalize)
//        request.execute(errorHandler: errorHandler) { [weak self] client in
//            guard let _ = self else { return }
//            TOUserDefaults.client.set(value: client)
//            completion?()
//        }
    }
}
