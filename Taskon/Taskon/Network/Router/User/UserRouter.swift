//
//  UserRouter.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Alamofire

enum UserRouter: NetworkRouter {
    
    case login(username: String, password: String)
    case logout(userId: Int)
    
    // Path
    var baseUrl: String {
        if let client = TOUserDefaults.client.get() {
            return client.wsUrl + "v1/Default.asmx/"
        }
        return NetworkConstants.k.production.baseURL
    }
    
    // Path
    var path: String {
        switch self {
        case .login: return "login"
        case .logout: return "logout"
        }
    }
    
    // Method
    var method: HTTPMethod {
        switch self {
        case .login, .logout: return .post
        }
    }
    
    // Token
    var token: Bool {
        switch self {
        case .login: return false
        case .logout: return true
        }
    }
    
    // API Key
    var apiKey: Bool {
        switch self {
        case .login, .logout: return true
        }
    }
    
    // Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let username, let password):
            return ["username" : username,
                    "password" : password]
        case .logout(let userId):
            return ["user_id" : userId]
        }
    }
}
