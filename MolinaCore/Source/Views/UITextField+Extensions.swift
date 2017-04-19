//
//  UITextField+Extensions.swift
//  Pods
//
//  Created by Jaren Hamblin on 4/18/17.
//
//

import Foundation
import UIKit

private var validationKey: UInt8 = 10

public extension UITextField {

    @IBInspectable
    public var ValidationFormat: String? {
        get {
            return objc_getAssociatedObject(self, &validationKey) as? String
        }
        set(newValue) {
            objc_setAssociatedObject(self, &validationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public func validate() -> Bool {
        guard let validationFormat: String = ValidationFormat, !validationFormat.isEmpty else { return true }
        guard let text: String = self.text else { return false }
        let isValid: Bool = text.validate(validationFormat)
        return isValid
    }
    
    public var isValid: Bool { return validate() }
    

}
