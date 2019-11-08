//
//  NetworkConstants.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 07/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

class NetworkConstants {
    
    // MARK: - Base Url
    struct k {
        struct production {
            static let baseURL = "http://taskmanager.saleseyes.com/"
        }
    }
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

enum ErrorCode: Int {
    case badRequest = 400
    case notAutorized = 401
    case timeOut = 408
    
    var description: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .notAutorized:
            return "Your session has expired."
        case .timeOut:
            return "Request time out."
        }
    }
}
