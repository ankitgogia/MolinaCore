//
//  String.swift
//  Swift extensions
//
//  Created by Anatoliy Voropay on 6/25/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import Foundation

extension String {
    
    /**
    :returns: Length of a string
    */
    public func length() -> Int {
        return self.characters.count
    }
    
    /**
    :returns: String without first and last whitespaces and new line characters
    */
    public func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /**
    :returns: Substring in current string starting at position `location` with `length`
    */
    public func substring(_ location: Int, length: Int) -> String! {
        var location = location
        if location >= self.length() {
            return ""
        }
        
        while location < 0 {
            location += self.length()
        }
        
        return (self as NSString).substring(with: NSMakeRange(location, length))
    }
    
    /**
    :returns: Character at `index` position
    */
    public subscript(index: Int) -> String! {
        get {
            return self.substring(index, length: 1)
        }
    }
    
    /**
    :returns: Location of a substring
    */
    public func location(_ substring: String) -> Int {
        return (self as NSString).range(of: substring).location
    }

    /**
    :returns: *true* string is numeric string
    */
    public func isNumeric() -> Bool {
        return (self as NSString).rangeOfCharacter(from: CharacterSet.decimalDigits.inverted).location == NSNotFound
    }

    public func replace(pattern aPattern: String, withString aString: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: aPattern, options: .caseInsensitive)
            let newString = regex.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.characters.count), withTemplate: aString)
            return newString
        } catch {
            return self
        }
    }

    public var titleized: String {
        var nameOfString = self
        nameOfString.replaceSubrange(nameOfString.startIndex...nameOfString.startIndex, with: String(nameOfString[nameOfString.startIndex]).capitalized)
        return nameOfString
    }

    public subscript(integerIndex: Int) -> Character {
        let index = characters.index(startIndex, offsetBy: integerIndex)
        return self[index]
    }

    public subscript(integerRange: Range<Int>) -> String {
        let start = characters.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = characters.index(startIndex, offsetBy: integerRange.upperBound)
        let range = start..<end
        return self[range]
    }

    // MARK: - Name Formatting
    
    public var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    /// Returns the initials
    public var initials: String {
        let fullName = self.trim()
        let components: [String] = fullName.components(separatedBy: " ")
        
        var initials: [String] = []
        if let first = components.first?.trim().characters.first {
            initials.append("\(first)")
        }
        if let last = components.last?.trim().characters.first {
            initials.append("\(last)")
        }
        
        let initial: String = initials.joined(separator: "").uppercased()
        return initial
    }

    /// Convert the string into Date specified by DateFormat
    public func toDate(_ format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

    
    public func contains(regex: String) -> Bool {
        return self.range(of: regex, options: String.CompareOptions.regularExpression) != nil
    }
    
    /// Returns an NSAttributedString formatted as HTML
    public func html() -> NSAttributedString {
        do {
            guard let data = self.data(using: String.Encoding.unicode, allowLossyConversion: true) else { return NSAttributedString(string: "") }
            let html = try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            return html
        } catch {
            return NSAttributedString(string: "")
        }
    }
    
    /// Returns a new String without HTML tags
    public func removeHtml() -> String {
        let aString = self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        return aString
    }
    
    /// Replaces any two+ white space characters with a single space
    public func removeExcessSpace() -> String {
        let aString = self.replacingOccurrences(of: "\\s{2,}", with: " ", options: String.CompareOptions.regularExpression, range: nil)
        return aString
    }
    
    /// Regex
    public func test(pattern: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", pattern)
        let result = test.evaluate(with: self)
        return result
    }
    
    /// Email Validation
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let result = self.test(pattern: emailRegEx)
        return result
    }
    
    /// ZipCode Validation
    public func isValidZipcode() -> Bool {
        let zipcodeRegEx = "^\\d{5}$"
        let result = self.test(pattern: zipcodeRegEx)
        return result
    }
    
    
    
    
    /// Accepts an optional String and returns the String unwrapped if it is not nil and is not whitespace, else returns the alternateString
    ///
    /// - Parameters:
    ///   - aString: String?
    ///   - alternateString: String
    /// - Returns: String
    public init(_ aString: String?, or alternateString: String) {
        if let nonOptionalString = aString?.trim(), !nonOptionalString.isEmpty && nonOptionalString != "" {
            self = nonOptionalString
        } else {
            self = alternateString
        }
    }
    
    
    /// Returns a random String with specified length
    public static func random(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
