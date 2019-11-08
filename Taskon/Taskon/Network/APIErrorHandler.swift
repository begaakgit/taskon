//
//  APIErrorHandler.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

protocol APIErrorHandler {
    var errorHandler: APIErrorHandlerCompletion { get }
}
