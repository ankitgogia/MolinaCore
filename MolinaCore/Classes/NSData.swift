//
//  NSData.swift
//  TeslaCopilot
//
//  Created by Jaren Hamblin on 6/25/16.
//  Copyright © 2016 JariousApps. All rights reserved.
//

import Foundation

extension Data {

    public init?(JSONObject: AnyObject) {
        guard let data = try? JSONSerialization.data(withJSONObject: JSONObject, options: JSONSerialization.WritingOptions.prettyPrinted) else { return nil }
        self.init(data)
    }

    public var JSONObject: Any? {
        guard let JSONObject = try? JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments) else { return nil }
        return JSONObject
    }

    public func removeComments() -> Data {
        guard let jsonString = String(data: self, encoding: String.Encoding.utf8) else { return self }
        let replacedJsonString = jsonString.replace(pattern: "\\/\\/(.+)?\n", withString: "")
        guard let data = replacedJsonString.data(using: String.Encoding.utf8) else { return self }
        return data
    }
}
