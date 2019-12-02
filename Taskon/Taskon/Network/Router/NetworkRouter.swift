//
//  NetworkRouter.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 07/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRouter: URLRequestConvertible {
    
    // MARK: - Class Properties
    
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var token: Bool { get }
    var apiKey: Bool { get }
    var parameters: Parameters? { get }
    
}


// MARK: - URLConvertible Methods

extension NetworkRouter {
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseUrl.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        request.httpMethod = method.rawValue
        
        // Common Headers
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if var parameters = parameters {
            
            // Add API Token
            if token {
                let token = TOUserDefaults.user.get()?.token ?? ""
                parameters["token"] = token
            }
            
            // Add API Key
            if apiKey {
                let apiKey = TOUserDefaults.client.get()?.apiKey ?? ""
                parameters["api_key"] = apiKey
            }
            
            if path == "sync_data" {
                let params: [String : Any] = ["data" : parameters]
                parameters.removeAll()
                parameters = params
            }
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return request
    }
}
