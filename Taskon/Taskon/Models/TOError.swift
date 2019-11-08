//
//  TOError.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

enum TOError: Error {
    case noInternet
    case stausCode(code: Int)
    case server(ErrorCodeTuple)
    case unknown(message: String)
}
