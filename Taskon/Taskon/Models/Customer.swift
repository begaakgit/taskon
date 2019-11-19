//
//  Customer.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 15/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct Customer: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let name: String
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "customer_id"
        case name = "customer_name"
    }
}


// MARK: - Customers Data

struct CustomerResponse: Codable {
    
    // MARK: - Class Propeties
    
    let time: Int
    let customers: [Customer]
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case time = "data_timestamp"
        case customers = "customers"
    }
}
