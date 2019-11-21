//
//  TaskPauseType.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 21/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct TaskPauseType: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let title: String
    let isDeleted: Int
    let sortValue: Int
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case isDeleted = "is_deleted"
        case sortValue = "sort_value"
    }
}
