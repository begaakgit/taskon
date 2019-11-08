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
    
    // MARK: - Private Methods
    
    @discardableResult
    static func performRequest<T: Decodable>(router: NetworkRouter,
                                             decoder: JSONDecoder = JSONDecoder()) -> Future<T> {
        return Future(operation: { completion in
            if Network.connected {
                Alamofire.request(router).responseDecodableObject { (response: DataResponse<T>) in
                    switch response.result {
                    case .success(let value): completion(.success(value))
                    case .failure(let error): completion(.failure(error))
                    }
                }
            } else {
                completion(.failure(TOError.noInternet))
            }
        })
    }
    
}
