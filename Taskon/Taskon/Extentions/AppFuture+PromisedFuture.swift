//
//  AppFuture+PromisedFuture.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import PromisedFuture

extension Future {
    
    // MARK: - Public Methods
    
    func execute(errorHandler: APIErrorHandlerCompletion? = nil,
                 errorFilter: ErrorCodeFilter? = nil,
                 onFailure failure: FailureCompletion? = nil,
                 onSuccess success: @escaping SuccessCompletion) {
        
        execute(onSuccess: success) {
            errorHandler?($0, errorFilter)
            failure?($0)
        }
        
    }
    
    func executeWith(errorHandler: APIErrorHandlerCompletion? = nil,
                     errorFilters: [APICodeFilter] = [],
                     onFailure failure: FailureCompletion? = nil,
                     onSuccess success: @escaping SuccessCompletion) {
        
        let filter: ErrorCodeFilter = { error in
            for err in errorFilters {
                if error.code == err.code {
                    err.callback()
                    return true
                }
            }
            return false
        }
        
        execute(onSuccess: success) {
            errorHandler?($0, filter)
            failure?($0)
        }
        
    }
    
}
