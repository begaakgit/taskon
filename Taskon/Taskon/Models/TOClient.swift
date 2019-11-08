//
//  TOClient.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct TOClient: Codable {
    
    // MARK: - Class Propeties
    
    let wsUrl: String
    let webUrl: String
    let apiKey: String
    let updateUrl: String
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case wsUrl = "ws_url"
        case webUrl = "web_url"
        case apiKey = "api_key"
        case updateUrl = "update_url"
    }
    
}


// MARK: - Company Service Response

struct TOClientServiceResponse: Codable {
    
    // MARK: - Class Propeties
    
    let result: TOClient?
    let error: ServiceError?
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case error = "error"
    }
}
