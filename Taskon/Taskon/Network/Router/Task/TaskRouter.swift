//
//  TaskRouter.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 15/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Alamofire

enum TaskRouter: NetworkRouter {
    
    case customers(userId: Int, search: String)
    case new(userId: Int, customerId: Int?, customerName: String, description: String, title: String)
    case coreData(userId: Int)
    
    
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
        case .customers: return "get_customers_data"
        case .new: return "sync_new_task"
        case .coreData: return "get_core_data"
        }
    }
    
    // Method
    var method: HTTPMethod {
        switch self {
        case .customers, .new, .coreData: return .post
        }
    }
    
    // Token
    var token: Bool {
        switch self {
        case .customers, .new, .coreData: return true
        }
    }
    
    // API Key
    var apiKey: Bool {
        switch self {
        case .customers, .new, .coreData: return true
        }
    }
    
    // Parameters
    var parameters: Parameters? {
        switch self {
        case .customers(let userId, let search):
            return ["user_id" : userId,
                    "search" : search]
         
        case .new(let userId, let customerId, let customerName, let description, let title):
            var params: Parameters = ["user_id" : userId,
                                      "description" : description,
                                      "title" : title,
                                      "customer_name" : customerName]
            
            if let customerId = customerId {
                params["customer_id"] = customerId
            }
            
            return params
            
        case .coreData(let userId):
            return ["user_id" : userId]
        }
    }
}
