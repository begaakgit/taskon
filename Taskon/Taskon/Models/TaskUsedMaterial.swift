//
//  TaskUsedMaterial.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 29/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct TaskUsedMaterial: Codable {
    
    // MARK: - Class Propeties
    
    var serverRecId: Int
    var id: Int
    var taskId: Int
    var userId: Int
    var type: Int
    var title: String
    var quantity: String?
    var price: String?
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case serverRecId = "serverRecId"
        case id = "material_id"
        case taskId = "task_id"
        case userId = "user_id"
        case type = "type"
        case title = "title"
        case quantity = "material_units"
        case price = "price"
    }
    
    
    // MARK: - Initialization Methods
    
    init(title: String, quantity: String?, price: String?, taskId: Int) {
        self.title = title.isEmpty ? "" : title
        self.quantity = quantity
        self.price = price
        self.taskId = taskId
        self.serverRecId = 0
        self.userId = TOUserDefaults.user.get()?.id ?? -1
        self.id = 0
        self.type = 0
    }
    
    
    // MARK: - Public Methods
    
    public func dictionary() -> [String : Any] {
        var dictionary: [String : Any] = [:]
        dictionary["material_units"] = quantity
        dictionary["material_id"] = 0
        dictionary["serverRecId"] = 0
        dictionary["task_id"] = taskId
        dictionary["type"] = type
        dictionary["price"] = price
        dictionary["title"] = title
        dictionary["record_id"] = 0
        return dictionary
    }

}
