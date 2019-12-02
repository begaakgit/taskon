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
    private var coreData: CoreData? = nil
    private var tasks: [Task] = []
    private var locations: [Location] = []
    private var searchText: String? = nil
    private var distanceFilter: Bool = false
    private var deadlineFilter: Bool = false
    private var seletedDate: Date? = nil
    private var animate: Bool = true
    
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
        searchController.searchBar.barStyle = .black
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupViewController() {
        tableView.tableFooterView = UIView(frame: .zero)
        performCoreDataRequest()
        performStaticDataRequest()
        
        sync = { [weak self] in
            guard let self = self else { return }
            self.performCoreDataRequest()
        }
    }
    
    private func updateUi() {
        if let coreData = coreData {
            if coreData.tasks.isEmpty {
                tasks.removeAll()
                locations.removeAll()
                tableView.setEmpty(text: Constants.Messages.noResult)
                
            } else {
                tasks = coreData.tasks
                locations = coreData.locations
                applyFilterOperation()
                tableView.reloadData()
                
                if tasks.count > 0 {
                    tableView.resetEmptyText()
                } else {
                    tableView.setEmpty(text: Constants.Messages.noResult)
                }
            }
            
        } else {
            tableView.setEmpty(text: Constants.Messages.noResult)
        }
    }
    
    private func applyFilterOperation() {
        if distanceFilter {
            tasks = tasks.sorted { $0.distance(with: locations) < $1.distance(with: locations) }
        }
        
        if deadlineFilter {
            tasks = tasks.sorted {
                $0.dueTimestamp.toDate(format: .short) ?? Date() < $1.dueTimestamp.toDate(format: .short) ?? Date()
            }
        }
        
        if let seletedDate = seletedDate {
            tasks = tasks.filter { $0.search(date: seletedDate) }
        }
        
        if let searchText = searchText,
            !searchText.isEmpty {
            tasks = tasks.filter { $0.search(text: searchText) }
        }
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
            guard let self = self else { return }
            self.animate = true
            self.updateUi()
            self.performCoreDataRequest()
        }
        return syncNewData
    }
    
    private func applyFilter() -> FilterCompletion {
        let applyFilter: FilterCompletion = { [weak self] filter in
            guard let self = self else { return }
            switch filter {
                
            case .distance:
                self.distanceFilter = true
                self.updateUi()
                
            case .deadLine:
                self.deadlineFilter = true
                self.updateUi()
                
            case .date:
                self.selectDate()
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
    
    private func filter(searchText: String?) {
        self.searchText = searchText
        updateUi()
    }

}


// MARK: - Navigation Methods

extension HomeViewController {
    
    private func createNewTask() {
        let createVC: NewTaskViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        createVC.addTaskCompletion = { [weak self] in
            guard let self = self else { return }
            self.animate = true
            self.updateUi()
            self.performCoreDataRequest()
        }
        let navController = AppNavigationController(rootViewController: createVC)
        present(navController, animated: true, completion: nil)
    }
    
    private func selectDate() {
        let datePickerVC: DatePickerViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        datePickerVC.datePickerCompletion = { [weak self] date in
            guard let self = self else { return }
            self.seletedDate = date
            self.updateUi()
        }
        let navController = AppNavigationController(rootViewController: datePickerVC)
        present(navController, animated: true, completion: nil)
    }
    
    private func showSettings() {
        let settingsVC: SettingsViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        let navController = AppNavigationController(rootViewController: settingsVC)
        present(navController, animated: true, completion: nil)
    }
    
    private func openDetails(for task: Task) {
        guard let location = locations.first(where: { $0.id == task.locationID }) else { return }
        let taskDetailVC: TaskDetailViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        
        var appTask = AppTask(task: task)
        appTask.materials = coreData?.getMaterials(for: task) ?? []
        taskDetailVC.appTask = appTask
        
        taskDetailVC.location = location
        push(viewController: taskDetailVC, animated: true)
    }
}


// MARK: - Search Controller Methods

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        filter(searchText: text)
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
        menuVC.preferredContentSize = CGSize(width: 250, height: 325)
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
        var rows = tasks.count
        
        if animate {
            rows = rows > 0 ? rows : 10
        }
        
        return rows
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: HomeCell.self) else { return UITableViewCell() }
        
        let task = animate ? nil : tasks[safe: indexPath.row]
        cell.configure(task: task, with: locations)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let task = tasks[safe: indexPath.row], !animate else { return }
        openDetails(for: task)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


// MARK: - API Request

extension HomeViewController {
    
    private func performCoreDataRequest() {
        let request = APIClient.coreData()
        
        let success: ServiceSuccess<CoreData> = { [weak self] coreData in
            guard let self = self else { return }
            self.coreData = coreData
            self.animate = false
            self.updateUi()
        }
        
        let failure: ServiceFailure = { [weak self] _ in
            guard let self = self else { return }
            self.coreData = nil
            self.animate = false
            self.updateUi()
        }
        
        request.execute(errorHandler: errorHandler, onFailure: failure, onSuccess: success)
    }
    
    private func performLogoutRequest() {
        let request = APIClient.logout()
        request.execute { [weak self] _ in
            guard let self = self else { return }
            self.logoutUser()
        }
    }
    
    private func performStaticDataRequest() {
        let request = APIClient.staticData()
        
        let success: ServiceSuccess<StaticData> = { [weak self] staticData in
            guard let _ = self else { return }
            TOUserDefaults.staticData.set(value: staticData)
        }
        
        request.execute(errorHandler: errorHandler, onSuccess: success)
    }
}
