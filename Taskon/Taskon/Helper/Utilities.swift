//
//  Utilities.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 08/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit


// MARK: - Registerable Protocol

protocol Registerable {
    static var identifier: String { get }
    static func getNIB() -> UINib
}

extension Registerable {

    static var identifier: String {
        return String(describing: self)
    }
    
    static func getNIB() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
