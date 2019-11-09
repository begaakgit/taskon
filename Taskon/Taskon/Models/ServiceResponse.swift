//
//  ServiceResponse.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct ServiceResponse<T: Codable>: Codable {
    
    // MARK: - Class Properties
    
    let data: ActualServiceResponse<T>?
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case data = "d"
    }
}

// MARK: - ActualServiceResponse

struct ActualServiceResponse<T: Codable>: Codable {
    
    // MARK: - Class Properties
    
    let value: T?
    let type: String?
    let message: String?
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case value = "d"
        case type = "type"
        case message = "message"
    }
}
