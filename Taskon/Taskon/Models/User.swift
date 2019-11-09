//
//  User.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct User: Codable {
    
    // MARK: - Class Propeties
    
    let options: [UserOptions]
    let serverTime: String
    let id: Int
    let token: String
    let firstname: String
    let lastname: String
    let title: String
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case options = "function_options"
        case serverTime = "server_time"
        case id = "id"
        case token = "token"
        case firstname = "firstname"
        case lastname = "lastname"
        case title = "title"
    }
}


// MARK: - User Options

struct UserOptions: Codable {
    
    // MARK: - Class Propeties
    
    let code: String
    let description: String
    let value: String
    
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case code = "unique_code"
        case description = "description"
        case value = "value"
    }
}
