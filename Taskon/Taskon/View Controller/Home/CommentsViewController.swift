//
//  CommentsViewController.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 21/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import SkeletonView
import KeyboardLayoutGuide

class CommentsViewController: AppViewController {
    
    
    // MARK: - Class Properties
    
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var messageInputView: SBMessageInputView!
    public var taskId: Int!
    private var comments: [Comment] = []
    private var animate: Bool = true
    private var comment: Comment? = nil
    private var canSend: Bool = false
    
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
}


// MARK: - Private Methods

extension CommentsViewController {
    
    private func setupNavigationBar() {
        navigationItem.title = "Comments"
    }
    
    private func setupViewController() {
        stackView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
        messageInputView.delegate = self
        performCommentsRequest()
    }
    
    private func updateUi() {
        if comments.isEmpty {
            tableView.setEmpty(text: Constants.Messages.noResult)
        } else {
            tableView.resetEmptyText()
        }
        tableView.reloadData()
    }
}


// MARK: - SBMessageInputView Methods

extension CommentsViewController: SBMessageInputViewDelegate {
    
    func inputView(textView: UITextView, shouldChangeTextInRange: NSRange, replacementText: String) -> Bool {
        canSend = true
        return true
    }
    
    func inputViewDidChange(textView: UITextView) { }
    
    func inputViewDidBeginEditing(textView: UITextView) { }
    
    func inputViewShouldBeginEditing(textView: UITextView) -> Bool {
        tableView.scrollToBottom()
        return true
    }
    
    func inputViewDidTapButton(button: UIButton) {
        guard let text = messageInputView.textView?.text,
            !text.isEmpty,
            text != messageInputView.placeholder,
            canSend,
            let user = TOUserDefaults.user.get() else { return }
        canSend = false
        comment = Comment(id: -1, taskId: taskId, author: "\(user.firstname) \(user.lastname)", message: text, timestamp: Date().getString(of: .timestamp))
        self.comments.append(comment!)
        let newIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0), section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [newIndexPath], with: .bottom)
        tableView.endUpdates()
        tableView.scrollToRow(at: newIndexPath, at: .top, animated: true)
        messageInputView.textView?.text = nil
        performCommentRequest()
    }

}


// MARK: - Table View Methods

extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = comments.count
        
        if animate {
            rows = rows > 0 ? rows : 5
        }
        
        return rows
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: CommentCell.self) else { return UITableViewCell() }
        
        let comment = animate ? nil : comments[safe: indexPath.row]
        cell.configure(comment: comment)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


// MARK: - API Request Methods
    
extension CommentsViewController {
    
    private func performCommentsRequest() {
        let request = APIClient.comments(taskId: taskId)
        
        let success: ServiceSuccess<TaskComment> = { [weak self] taskComment in
            guard let self = self else { return }
            self.comments.removeAll()
            self.comments = taskComment.comments.reversed()
            self.animate = false
            self.updateUi()
        }
        
        let failure: ServiceFailure = { [weak self] _ in
            guard let self = self else { return }
            self.comments.removeAll()
            self.animate = false
            self.updateUi()
        }
        
        request.execute(errorHandler: errorHandler, onFailure: failure, onSuccess: success)
    }
    
    private func performCommentRequest() {
        let request = APIClient.comment(taskId: taskId, comment: comment?.message ?? "")
        
        let success: ServiceSuccess<EmptyCodable> = { [weak self] _ in
            guard let self = self else { return }
            self.comment = nil
        }
        
        let failure: ServiceFailure = { [weak self] _ in
            guard let self = self else { return }
            self.comment = nil
        }
        
        request.execute(errorHandler: errorHandler, onFailure: failure, onSuccess: success)
    }
}
