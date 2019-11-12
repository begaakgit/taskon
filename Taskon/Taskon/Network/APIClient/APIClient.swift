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

class APIClient {
    
    // MARK: - Class Methods
    
    @discardableResult
    static func performRequest<T: Codable>(router: NetworkRouter,
                                           decoder: JSONDecoder = JSONDecoder()) -> Future<T> {
        return Future(operation: { completion in
            if Network.connected {
                // Perform Request
                let dataRequest = Alamofire.request(router)
                dataRequest.responseData { response in
                    switch response.result {
                    case .success(let date):
                        // Decode Response Here to Map Model
                        parse(date: date, decoder: decoder, success: {
                            dataRequest.responseDecodableObject { (actualResponse: DataResponse<T>) in
                                switch actualResponse.result {
                                case .success(let value): completion(.success(value))
                                case .failure(let error): completion(.failure(error))
                                }
                            }
                        }) { (error) in
                            completion(.failure(error))
                        }
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            } else {
                // Network Not Connected
                completion(.failure(TOError.noInternet))
            }
        })
    }
    
    @discardableResult
    static func performClientRequest<T: Codable>(router: NetworkRouter,
                                                 decoder: JSONDecoder = JSONDecoder()) -> Future<T> {
        return Future(operation: { completion in
            if Network.connected {
                // Perform Request
                Alamofire.request(router).responseDecodableObject { (response: DataResponse<T>) in
                    switch response.result {
                    case .success(let value): completion(.success(value))
                    case .failure(let error): completion(.failure(error))
                    }
                }
                
            } else {
                // Network Not Connected
                completion(.failure(TOError.noInternet))
            }
        })
    }
    
    
    // MARK: - Private Methods
    
    private static func parse(date: Data,
                              decoder: JSONDecoder,
                              success: VoidCompletion,
                              failure: ServiceFailure) {
        
        do {
            if let json = try JSONSerialization.jsonObject(with: date, options: .allowFragments) as? [String : Any] {
                // Json
                if let jsonData = json["d"] as? [String : Any] {
                    
                    if let errorMessage = jsonData["message"] as? String {
                        // Error in API
                        failure(TOError.unknown(message: errorMessage))
                    } else {
                        // Success API Call
                        success()
                    }
                    
                } else {
                    // Error in API
                    let message = "Unknown error code \(NetworkConstants.ParsingError.serviceError)"
                    failure(TOError.unknown(message: message))
                }
            } else {
                // Error in Response
                let message = "Unknown error code \(NetworkConstants.ParsingError.jasonSerializationFailed)"
                failure(TOError.unknown(message: message))
            }
        } catch (let error) {
            let message = error.localizedDescription
            failure(TOError.unknown(message: message))
        }
        
    }
    
}
