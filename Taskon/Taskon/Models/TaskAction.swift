//
//  TaskAction.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 02/12/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct TaskAction: Codable {
    
    
    // MARK: - Class Propeties
    
    var id: Int
    var taskId: Int
    var locationId: Int
    var accept: Int
    var pause: Int
    var stop: Int
    var startTime: Date?
    var stopTime: Date?
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case taskId = "task_id"
        case locationId = "location_id"
        case accept = "task_accept_id"
        case pause = "task_pause_id"
        case stop = "task_stop_id"
        case startTime = "action_start"
        case stopTime = "action_stop"
    }
    
    
    // MARK: - Public Methods
    
    public func dictionary() -> [String : Any]? {
        return json()
    }

}
