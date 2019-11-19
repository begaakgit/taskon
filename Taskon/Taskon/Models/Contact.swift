//
//  Contact.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 18/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct Contact: Codable {
    
    // MARK: - Class Propeties
    
    let id: Int
    let name: String
    let phone: String
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case id = "contact_id"
        case name = "contact"
        case phone = "contact_phone"
    }
}
