//
//  CompanyRouter.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 07/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Alamofire

enum CompanyRouter: NetworkRouter {
    
    case login(code: String)
    
    // Method
    var method: HTTPMethod {
        switch self {
        case .login: return .post
        }
    }
    
    // Path
    var path: String {
        switch self {
        case .login: return "saas/login/"
        }
    }
    
    // Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let code): return ["company_code" : code]
        }
    }
}
