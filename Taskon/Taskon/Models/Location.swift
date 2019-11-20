//
//  Location.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 19/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct Location: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let title: String
    let latitude: String
    let longitude: String
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}
