//
//  TaskDetailViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 20/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import CoreLocation
import ImageViewer

enum TaskDetailState {
    case registered
    case approved
    case inProgress
    case notFinished
}

enum Sections: Int, CaseIterable {
    case additional
    case info
    case photos
}

enum AdditionalRows: Int, CaseIterable {
    case users
    case materials
    case jobs
}

enum InfoRows: Int, CaseIterable {
    case status
    case photo
    case title
    case description
    case comments
    case address
    case contacts
}

class TaskDetailViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private weak var tableView: UITableView!
    public var appTask: AppTask!
    public var location: Location!
    private var state: TaskDetailState = .registered
    private var photosManager: PhotosManager!
    private var images: [TaskImage] = []
    private var showFirstSection: Bool = false
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
    deinit {
        if !images.isEmpty {
            if let taskImages = TOUserDefaults.taskImages.get() {
                TOUserDefaults.taskImages.clear()
                TOUserDefaults.taskImages.set(value: taskImages + images)
            } else {
                TOUserDefaults.taskImages.set(value: images)
            }
        }
    }

}


// MARK: - Private Methods

extension TaskDetailViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = appTask.task.nr
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupViewController() {
        
        switch appTask.task.status {
        case .inProgress:
            state = .inProgress
            showFirstSection = true
            LocationManager.default.startLogging(with: appTask.task.id, locationId: appTask.task.locationID)
        case .approved:
            state = .approved
            showFirstSection = false
        case .registered:
            state = .registered
            showFirstSection = false
        default:
            state = .notFinished
            showFirstSection = false
        }
        
        tableView.tableFooterView = UIView(frame: .zero)
        if let taskImages = TOUserDefaults.taskImages.get() {
            images = taskImages.filter { $0.taskId == appTask.task.id }
            updateImageCache()
        }
        tableView.reloadData()
    }
    
    private func updateImageCache() {
        if var taskImages = TOUserDefaults.taskImages.get() {
            taskImages.removeAll { image in
                return images.contains { $0.taskId == image.taskId }
            }
            TOUserDefaults.taskImages.set(value: taskImages)
        }
    }
    
    private func additionalCell(for row: Int) -> UITableViewCell {
        guard let row = AdditionalRows(rawValue: row),
            let cell = tableView.getCell(type: NormalCell.self) else { return UITableViewCell() }
        switch row {
        case .users: cell.configureForUsers()
        case .materials: cell.configureForMaterials()
        case .jobs: cell.configureForJobs()
        }
        return cell
    }
    
    private func infoCell(for row: Int) -> UITableViewCell {
        guard let row = InfoRows(rawValue: row) else { return UITableViewCell() }
        switch row {
        case .status:
            guard let cell = tableView.getCell(type: StatusCell.self) else { return UITableViewCell() }
            cell.configure(task: appTask.task)
            return cell
            
        case .photo:
            guard let cell = tableView.getCell(type: ActionCell.self) else { return UITableViewCell() }
            cell.delegate = self
            cell.configure(for: state)
            return cell
            
        case .title:
            guard let cell = tableView.getCell(type: NormalCell.self) else { return UITableViewCell() }
            cell.configure(title: appTask.task.title)
            return cell
            
        case .description:
            guard let cell = tableView.getCell(type: NormalCell.self) else { return UITableViewCell() }
            cell.configure(description: appTask.task.description)
            return cell
            
        case .comments:
            guard let cell = tableView.getCell(type: NormalCell.self) else { return UITableViewCell() }
            cell.configureForComments()
            return cell
            
        case .address:
            guard let cell = tableView.getCell(type: NormalCell.self) else { return UITableViewCell() }
            cell.configure(address: appTask.task.customerNamePrint + " (" + location.title + ")")
            return cell
            
        case .contacts:
            guard let cell = tableView.getCell(type: ContactCell.self) else { return UITableViewCell() }
            if let contacts = appTask.task.contacts, let contact = contacts.first {
                cell.configure(contact: contact)
            }
            return cell
        }
    }
    
    private func add(image: UIImage, location: CLLocation?) {
        if let location = location {
            LocationManager.default.address(for: location) { [weak self] address in
                guard let self = self else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if let imageString = image.base64String() {
                        let imageAddress = "\(address?.name ?? ""), \(address?.locality ?? ""), \(address?.country ?? "")"
                        let taskImage = TaskImage(image: imageString, address: imageAddress, taskId: self.appTask.task.id)
                        self.images.append(taskImage)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    private func deleteImage(at indexPath: IndexPath) {
        images.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    private func startNewTask() {
        state = .approved
        tableView.reloadData()
    }
    
    private func startPauseTask() {
        state = .inProgress
        tableView.reloadData()
    }
    
    private func pauseTask() {
        state = .notFinished
        tableView.reloadData()
    }
    
    private func finishTask() {
        let finishTaskVC: TaskFinishedViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        finishTaskVC.location = location
        push(viewController: finishTaskVC, animated: true)
    }

}


// MARK: - Navigation Methods

extension TaskDetailViewController {
    
    private func openComments() {
        let commentsVC: CommentsViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        commentsVC.taskId = appTask.task.id
        push(viewController: commentsVC, animated: true)
    }
    
    private func openMap() {
        let mapVC: MapViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        mapVC.location = location
        push(viewController: mapVC, animated: true)
    }
    
    private func openContacts() {
        if let contacts = appTask.task.contacts,
            !contacts.isEmpty {
            let contactsVC: ContactsViewController = instanceFromStoryboard(storyboard: Storyboard.home)
            contactsVC.contacts = contacts
            push(viewController: contactsVC, animated: true)
        }
    }
    
    private func openPhotos() {
        photosManager = PhotosManager(viewController: self)
        photosManager.selectedImage = { [weak self] image, location in
            guard let self = self else { return }
            self.add(image: image, location: location)
        }
        photosManager.start()
    }
    
    private func openUpdateTask(mode: UpdateTaskMode) {
        let updateTaskVC: UpdateTaskViewController = instanceFromStoryboard(storyboard: Storyboard.home)
        updateTaskVC.mode = mode
        updateTaskVC.taskId = appTask.task.id
        push(viewController: updateTaskVC, animated: true)
    }
    
    private func openGallery(at indexPath: IndexPath) {
        let galleryVC = GalleryViewController(startIndex: indexPath.row, itemsDataSource: self)
        present(galleryVC, animated: true, completion: nil)
    }
    
}


// MARK: - TableView Methods
    
extension TaskDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if let section = Sections(rawValue: section) {
            switch section {
            case .additional:
                if showFirstSection {
                    rows = AdditionalRows.allCases.count
                } else {
                    rows = 0
                }

            case .info:
                if let contacts = appTask.task.contacts, !contacts.isEmpty {
                    rows = InfoRows.allCases.count
                } else {
                    rows = InfoRows.allCases.count - 1
                }
                
            case .photos:
                rows = images.count
            }
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Sections(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .additional: return additionalCell(for: indexPath.row)
            
        case .info: return infoCell(for: indexPath.row)
            
        case .photos:
            guard let cell = tableView.getCell(type: ImageCell.self) else { return UITableViewCell() }
            let image = images[indexPath.row]
            cell.configure(image: image) { [weak self] in
                guard let self = self else { return }
                self.deleteImage(at: indexPath)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let section = Sections(rawValue: indexPath.section) {
            switch section {
            case .additional:
                if let row = AdditionalRows(rawValue: indexPath.row) {
                    switch row {
                    case .users: openUpdateTask(mode: .user(users: appTask?.users ?? []))
                    case .materials: openUpdateTask(mode: .material(materials: appTask?.materials ?? []))
                    case .jobs: openUpdateTask(mode: .job(jobs: appTask?.jobs ?? []))
                    }
                }
                
            case .info:
                if let row = InfoRows(rawValue: indexPath.row) {
                    switch row {
                    case .comments: openComments()
                    case .address: openMap()
                    case .contacts: openContacts()
                    default: break
                    }
                }
                
            case .photos:
                openGallery(at: indexPath)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        
        if let sec = Sections(rawValue: section) {
            switch sec {
            case .photos:
                let label = UILabel(frame: .zero)
                label.text = "Photos & Reports"
                label.textColor = .darkGray
                label.font = .toFront(ofSize: 17)
                view.addSubview(label)
                label.snp.makeConstraints {
                    $0.leading.equalToSuperview().offset(20)
                    $0.trailing.equalToSuperview()
                    $0.top.equalToSuperview().offset(10)
                    $0.bottom.equalToSuperview()
                }
                
            default:
                break
            }
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 0.01
        
        if let sec = Sections(rawValue: section) {
            switch sec {
            case .photos: height = images.isEmpty ? 0.01 : 30
            default: height = 0.01
            }
        }
        
        return height
    }
}


// MARK: Action Cell Methods

extension TaskDetailViewController: ActionCellDelegate {
    
    func cameraButtonTapped() {
        openPhotos()
    }
    
    func acceptTaskTapped() {
        startNewTask()
    }
    
    func startTaskTapped() {
        startPauseTask()
    }
    
    func stopTaskTapped() {
        pauseTask()
    }
    
    func finishTaskTapped() {
        finishTask()
    }
    
}


// MARK: - Ga Methods

extension TaskDetailViewController: GalleryItemsDataSource {
    
    func itemCount() -> Int {
        return images.count
    }
    
    func provideGalleryItem(_ index: Int) -> GalleryItem {
        let image = images[index]
        if let item = image.image.image() {
            return .image { [weak self] in $0(item) }
        }
        return .image { $0(nil) }
    }
    
    
}
