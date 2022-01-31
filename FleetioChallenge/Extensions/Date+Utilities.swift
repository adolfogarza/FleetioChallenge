//
//  Date+Utilities.swift
//  FleetioChallenge
//
//  Created by Adolfo Hernandez Garza on 1/27/22.
//

import Foundation

// MARK: - Date Utilities

extension Date {
    
    /// Reusable custom date formatter instantiated only once because at least in older versions of
    /// iOS this instantiation would be an expensive operation if repeated regularly.
    static let customDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter
    }()
    
    static let humanReadableDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }()
}
