//
//  UserPreferences.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 3/6/17.
//  Copyright © 2017 Molina Healthcare, Inc. All rights reserved.
//

import Foundation

public class UserPreferences {
    
    fileprivate let userIdentifier: String
    fileprivate let userDefaults: UserDefaults
    
    fileprivate struct Constants {
        static let preferenceTouchId = "com.app.PreferenceTouchId"
    }
    
    public init(userIdentifier: String) {
        self.userIdentifier = userIdentifier
        self.userDefaults = UserDefaults(suiteName: userIdentifier)!
    }
    
    
    
    
    
    // MARK: - Default User Preference Instance Properties
    
    /// Touch ID preference
    public var isTouchIdEnabled: Bool {
        get {
            let value = userDefaults.bool(forKey: Constants.preferenceTouchId)
            return value
        }
        set {
            userDefaults.set(newValue, forKey: Constants.preferenceTouchId)
            userDefaults.synchronize()
        }
    }
    
    
    
    
    
    
    // MARK: - Default User Preference Static Methods
    
    /// Returns the Touch ID preference
    public static func getTouchIdPreference(for userIdentifier: String?) -> Bool {
        guard let userIdentifier = userIdentifier else { return false }
        let value = UserPreferences(userIdentifier: userIdentifier).isTouchIdEnabled
        return value
    }
    
    /// Updates the Touch ID preference
    public static func setTouchID(enabled: Bool, for userIdentifier: String?) {
        guard let userIdentifier = userIdentifier else { return }
        UserPreferences(userIdentifier: userIdentifier).isTouchIdEnabled = enabled
    }
}
