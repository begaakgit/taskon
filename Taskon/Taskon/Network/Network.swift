//
//  Network.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation
import Reachability

class Network {
    
    // MARK: - Class Methods
    
    open class var connected: Bool {
        do {
            let reachability = try Reachability()
            switch reachability.connection {
            case .unavailable, .none: return false
            case .cellular, .wifi: return true
            }
        } catch {
            debugPrint(error.localizedDescription)
            return false
        }
    }
    
}
