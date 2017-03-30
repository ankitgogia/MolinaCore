//
//  LocalizedString.swift
//  MolinaCore
//
//  Created by Jaren Hamblin on 3/14/17.
//  Copyright © 2017 Molina. All rights reserved.
//

import Foundation


/// Returns a localized `String`. Attempts to retrieve the `NSLocalizedString` from the base Location.strings file. If the `NSLocalizedString` returns the key, then the `defaultString` is used. If the `defaultString` is unavailable, then the key is used. If the key is unavailable, then defaults to an empty `String`.
///
/// - Parameters:
///   - key: String?
///   - defaultString: String?
/// - Returns: String
public func LocalizedString(_ key: String?, `default` defaultString: String? = nil) -> String {
    
    var localizedString: String? = nil
    
    if let key = key {
        
        // First attempt: Use the base Location.strings file
        if localizedString == nil {
            let nsLocalizedString = NSLocalizedString(key, comment: key)
            if key != nsLocalizedString {
                // Only use the NSLocalizedString if the value is not the same as the key
                localizedString = nsLocalizedString
            }
        }
        
        // Second attempt: Use the default string if available
        if localizedString == nil {
            localizedString = defaultString
        }
        
        // Third attempt: Use the key
        if localizedString == nil {
            localizedString = key
        }
    }
    
    return localizedString ?? ""
}
