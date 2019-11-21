//
//  Comment.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 21/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct Comment: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let taskId: Int
    let author: String
    let message: String
    let timestamp: String
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "comment_id"
        case taskId = "task_id"
        case author = "author"
        case message = "task_comment"
        case timestamp = "timestamp"
    }
}


// MARK: - Task Comment

struct TaskComment: Codable {
    
    // MARK: - Class Propeties
    
    let timestamp: Int
    let comments: [Comment]
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "data_timestamp"
        case comments = "task_comments"
    }
}
