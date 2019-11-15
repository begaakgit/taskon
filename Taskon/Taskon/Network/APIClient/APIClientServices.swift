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
    
    // MARK: Client Methods
    
    static func login(company code: String) -> Future<TOClient> {
        let router = CompanyRouter.login(code: code)
        let responseFuture: Future<TOClientServiceResponse> = performClientRequest(router: router)
        return resolve(clientResponse: responseFuture)
    }
    
    
    // MARK: User Methods
    
    static func login(username: String, password: String) -> Future<User> {
        let router = UserRouter.login(username: username, password: password)
        let responseFuture: Future<ServiceResponse<User>> = performRequest(router: router)
        return resolve(response: responseFuture)
    }
    
    static func logout() -> Future<EmptyCodable> {
        let userId = TOUserDefaults.user.get()?.id ?? -1
        let router = UserRouter.logout(userId: userId)
        let responseFuture: Future<ServiceResponse<EmptyCodable>> = performRequest(router: router)
        return resolve(response: responseFuture)
    }
    
    
    // MARK: Task Methods
    
    static func customers(search: String) -> Future<CustomerResponse> {
        let userId = TOUserDefaults.user.get()?.id ?? -1
        let router = TaskRouter.customers(userId: userId, search: search)
        let responseFuture: Future<ServiceResponse<CustomerResponse>> = performRequest(router: router)
        return resolve(response: responseFuture)
    }
    
    static func newTask(title: String, description: String, customerId: Int?, customerName: String) -> Future<EmptyCodable> {
        let userId = TOUserDefaults.user.get()?.id ?? -1
        let router = TaskRouter.new(userId: userId, customerId: customerId, customerName: customerName, description: description, title: title)
        let responseFuture: Future<ServiceResponse<EmptyCodable>> = performRequest(router: router)
        return resolve(response: responseFuture)
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
    
    private static func resolve<T: Decodable>(response: Future<ServiceResponse<T>>) -> Future<T> {
        return Future(operation: { completion in
            response.execute { result in
                switch result {
                case .success(let value):
                    completion(.success(value.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        })
    }
    
}
