//
//  AppString+String.swift
//  Taskon
//
//  Created by Muhammad Khaliq ur Rehman on 06/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

extension String {
    
    // MARK: - Class Properties
    
    public var normalize: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func toDate(format: DateFormatType, ignoreTimeZone: Bool = false) -> Date? {
        return format.getFormatter(ignoreTimeZone: ignoreTimeZone).date(from: self)
    }
    
}
