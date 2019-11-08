//
//  ServiceError.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct ServiceError: Codable {

    
    // MARK: - Class Propeties
    
    let code: String
    let message: String
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
    }
}
