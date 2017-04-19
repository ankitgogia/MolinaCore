//
//  StringValidator.swift
//  Pods
//
//  Created by Jaren Hamblin on 4/18/17.
//
//

import Foundation

public struct StringValidationFormat {
    public static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    public static let zipCode5 = "^\\d{5}$"
}



public struct StringValidator {
    
    public init() {}
    
    public static func validate(_ aString: String?, with format: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", format)
        let result = test.evaluate(with: aString)
        return result
    }

}


// MARK: - Convenience String Extensions

public extension String {

    /// Validate a String against a given regular expression format
    ///
    /// - Parameter regex: A regular expression String
    /// - Returns: Bool
    public func validate(_ regex: String) -> Bool { return StringValidator.validate(self, with: regex) }
 
    /// Validate a String using an Email Address regular exression format
    public var isValidEmailAddress: Bool { return self.validate(StringValidationFormat.email) }
    
    /// Validate a String using a 5 Digit Zip Code regular expression format
    public var isValidZipCode5: Bool { return self.validate(StringValidationFormat.zipCode5) }
}
