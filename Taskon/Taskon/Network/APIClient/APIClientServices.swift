//
//  APIClientServices.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import PromisedFuture

extension APIClient {
    
    // MARK: - Public Class Methods
    
    static func login(company code: String) -> Future<TOClient> {
        let router = CompanyRouter.login(code: code)
        let responseFuture: Future<TOClientServiceResponse> = performRequest(router: router)
        return resolve(clientResponse: responseFuture)
    }
    
    static func login(username: String, password: String) -> Future<EmptyCodable> {
        let apiKey = TOUserDefaults.client.get()?.apiKey ?? ""
        let router = UserRouter.login(username: username, password: password, apiKey: apiKey)
        let responseFuture: Future<EmptyCodable> = performRequest(router: router)
        return responseFuture
    }
    
    
    // MARK: - Private Methods
    
    private static func resolve(clientResponse: Future<TOClientServiceResponse>) -> Future<TOClient> {
        return Future(operation: { completion in
            clientResponse.execute { result in
                switch result {
                case .success(let serviceResponse):
                    if let result = serviceResponse.result {
                        completion(.success(result))
                    } else {
                        if let serviceError = serviceResponse.error {
                            let error = TOError.server(ErrorCodeTuple(code: Int(serviceError.code ?? "-1") ?? -1, message: serviceError.message))
                            completion(.failure(error))
                        }
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        })
    }
    
}
