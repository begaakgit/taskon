//
//  TaskType.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 21/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct TaskType: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let parentId: Int?
    let title: String
    let isLeaf: Int
    let taskClassId: Int
    let isDeleted: Int
    let sortValue: Int
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case parentId = "parent_id"
        case title = "title"
        case isLeaf = "is_leaf"
        case taskClassId = "task_class_id"
        case isDeleted = "is_deleted"
        case sortValue = "sort_value"
    }
}
