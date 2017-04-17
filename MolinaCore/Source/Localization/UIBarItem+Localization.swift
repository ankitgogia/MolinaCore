//
//  UIBarItem+Localization.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 4/5/17.
//  Copyright © 2017 Molina Healthcare, Inc. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

private var localizationKey: UInt8 = 2

public extension UIBarItem {
    /// Localization Key used to reference the unique translation and text required.
    @IBInspectable
    public var LocalizeKey: String? {
        get {
            return objc_getAssociatedObject(self, &localizationKey) as? String
        }
        set(newValue) {
            objc_setAssociatedObject(self, &localizationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            updateLocalisation()
        }
    }
    
    /// update the localization
    public func updateLocalisation() {
        if ((self.LocalizeKey?.isEmpty) != nil)  {
            if self.title == nil {
                let languageString = LocalizedString(self.LocalizeKey!, default: self.LocalizeKey!)
                self.title = languageString
            } else {
                let languageString = LocalizedString(self.LocalizeKey!, default: self.title!)
                self.title = languageString
            }
        } else {
            self.title = ""
        }
    }
}
