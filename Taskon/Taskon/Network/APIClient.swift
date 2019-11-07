//
//  APIClient.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 07/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire
import PromisedFuture

class cc: Codable {
    
}

class APIClient {
    
    // MARK: - Public Class Methods
    
    static func login(company code: String) -> Future<cc> {
        let router = CompanyRouter.login(code: code)
        return performRequest(router: router)
    }
    
    
    // MARK: - Private Methods
    
    @discardableResult
    private static func performRequest<T: Decodable>(router: NetworkRouter,
                                                     decoder: JSONDecoder = JSONDecoder()) -> Future<T> {
        return Future(operation: { completion in
            Alamofire.request(router).responseDecodableObject { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value): completion(.success(value))
                case .failure(let error): completion(.failure(error))
                }
            }
        })
    }
    
}
