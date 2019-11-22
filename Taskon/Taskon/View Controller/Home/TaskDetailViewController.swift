//
//  TaskDetailViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 20/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit

enum TaskDetailState {
    case registered
    case approved
    case inProgress
}

class TaskDetailViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private weak var tableView: UITableView!
    public var task: Task!
    public var location: Location!
    private var state: TaskDetailState = .registered
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        openMap(for: location)
    }
}


// MARK: - Private Methods

extension TaskDetailViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = task.nr
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupViewController() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
}


// MARK: - Navigation Methods

extension TaskDetailViewController {
    
    private func openComments(for taskId: Int) {
        let commentsVC: CommentsViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        commentsVC.taskId = taskId
        push(viewController: commentsVC, animated: true)
    }
    
    private func openMap(for location: Location) {
        let mapVC: MapViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        mapVC.location = location
        push(viewController: mapVC, animated: true)
    }
    
}


// MARK: - TableView Methods
    
extension TaskDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ContactCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
