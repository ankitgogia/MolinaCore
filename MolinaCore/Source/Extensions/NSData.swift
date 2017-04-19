//
//  NSData.swift
//  TeslaCopilot
//
//  Created by Jaren Hamblin on 6/25/16.
//  Copyright © 2016 JariousApps. All rights reserved.
//

import Foundation

extension Data {
    
    public init?(json: Any) {
        guard let data = try? JSONSerialization.data(withJSONObject: json) else { return nil }
        self.init(data)
    }
    
    public init?(json: [String: Any]) {
        self.init(json: json)
    }
    
    public init?(json: AnyObject) {
        self.init(json: json)
    }

    public var json: Any? {
        guard let json = try? JSONSerialization.jsonObject(with: self) else { return nil }
        return json
    }
    
    public var jsonDictionary: [String: Any]? {
        let jsonDictionary = self.json as? [String: Any]
        return jsonDictionary
    }
}


// MARK: - Deprecated

extension Data {
    @available(*, deprecated: 10.0, message: "Use init(json:_)")
    public init?(JSONObject: AnyObject) {
        guard let data = try? JSONSerialization.data(withJSONObject: JSONObject, options: JSONSerialization.WritingOptions.prettyPrinted) else { return nil }
        self.init(data)
    }
    
    @available(*, deprecated: 10.0, message: "Use init(json:_)")
    public var JSONObject: Any? {
        guard let JSONObject = try? JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments) else { return nil }
        return JSONObject
    }
    
    @available(*, deprecated: 10.0)
    public func removeComments() -> Data {
        guard let jsonString = String(data: self, encoding: String.Encoding.utf8) else { return self }
        let replacedJsonString = jsonString.replace(pattern: "\\/\\/(.+)?\n", withString: "")
        guard let data = replacedJsonString.data(using: String.Encoding.utf8) else { return self }
        return data
    }
}
