//
//  APICodeFilter.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

struct APICodeFilter {
    
    // MARK: - Class Properties
    
    var code: Int
    var callback: VoidCompletion
    
    
    // MARK: - Initialization Methods
    
    init(code statusCode: Int, completion: @escaping VoidCompletion) {
        code = statusCode
        callback = completion
    }
}
