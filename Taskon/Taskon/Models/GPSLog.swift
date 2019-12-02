//
//  GPSLog.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 02/12/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct GPSLog: Codable {
    
    
    // MARK: - Class Propeties
    
    var id: Int
    var timestamp: String
    var longitude: Double
    var latitude: Double
    var precision: Double
    var taskId: Int
    var locationId: Int
    var coordinateTypeId: Int
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "serverRecId"
        case timestamp = "log_timestamp"
        case longitude = "user_longitude"
        case latitude = "user_latitude"
        case precision = "gps_precision"
        case taskId = "task_id"
        case locationId = "location_id"
        case coordinateTypeId = "coordinate_type_id"
    }
    
    
    // MARK: - Public Methods
    
    public func dictionary() -> [String : Any]? {
        return json()
    }

}
