//
//  CoreData.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 19/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct CoreData: Codable {
    
    // MARK: - Class Propeties
    
    let time: Int
    let tasks: [Task]
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case time = "data_timestamp"
        case tasks = "tasks"
    }
}
