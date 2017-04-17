//
//  UITextField+Localization.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 4/5/17.
//  Copyright © 2017 Molina Healthcare, Inc. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

private var localizationKey: UInt8 = 3

public extension UITextField {
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
    
    /// update localization from notification on main thread
    @objc private func updateLocalizationFromNotification() {
        DispatchQueue.main.async(execute: {
            self.updateLocalisation()
        })
        
    }
    
    /// update the localization
    public func updateLocalisation() {
        if ((self.LocalizeKey?.isEmpty) != nil)  {
            let placeHolderKey = self.LocalizeKey!;
            if self.placeholder == nil {
                let languageString = LocalizedString(placeHolderKey, default: placeHolderKey)
                self.placeholder = languageString
            } else {
                let languageString = LocalizedString(placeHolderKey, default: self.placeholder!)
                self.placeholder = languageString
            }
        }
    }
}
