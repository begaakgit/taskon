//
//  AppEncodable+Encodable.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 02/12/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

extension Encodable {
    
    // MARK: - Public Methods
    
    public func json() -> [String : Any]? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let dictionary = json as? [String : Any] {
                return dictionary
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
