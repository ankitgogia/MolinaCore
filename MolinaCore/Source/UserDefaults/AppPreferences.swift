//
//  PreferencesManager.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 11/30/16.
//  Copyright © 2016 Molina Healthcare Inc. All rights reserved.
//

import Foundation

public class AppPreferences {

    public let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

}
