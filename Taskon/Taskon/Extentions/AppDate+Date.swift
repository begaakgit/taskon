//
//  AppDate+Date.swift
//  Taskon
//
//  Created by Khaliq ur Rehman on 09/11/2019.
//  Copyright © 2019 Muhammad Khaliq ur Rehman. All rights reserved.
//

import Foundation

extension Date {
    
    // MARK: - Class Methods
    
    func getString(of type: DateFormatType, addTimeZone: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        
        if addTimeZone {
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        
        formatter.dateFormat = type.getFormat()
        return formatter.string(from: self)
    }
}


// MARK: - Date Formate

enum DateFormatType {
    case dayName
    case dayOfMonth
    case month
    case monthShort
    case year
    case formatted
    case timezone
    case monthYear
    case dateTimeShort
    case normal
    
    func getFormat() -> String {
        switch self {
        case .dayName: return "EEEE"
        case .dayOfMonth: return "dd"
        case .month: return "MM"
        case .monthShort: return "MMM"
        case .year: return "yyyy"
        case .timezone: return "yyyy-MM-dd'T'HH:mm:sssZ"
        case .formatted: return "EEE, MMM d, yyyy"
        case .monthYear: return "MM/yyyy"
        case .dateTimeShort: return "MMMM d, hh:mm a"
        case .normal: return "MMMM d, yyyy"

        }
    }
    
    func getFormatter(ignoreTimeZone: Bool = false) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        if ignoreTimeZone == false  {
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        formatter.dateFormat = getFormat()
        return formatter
    }

}
