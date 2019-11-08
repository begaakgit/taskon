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
    
    case login(username: String, password: String, apiKey: String)
    
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
        }
    }
    
    // Method
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        }
    }
    
    // Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let username, let password, let apiKey):
            return ["username" : username,
                    "password" : password,
                    "api_key" : apiKey]
        }
    }
}
