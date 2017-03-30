//
//  JSONSerialization.swift
//  MolinaCore
//
//  Created by Jaren Hamblin on 11/2/16.
//  Copyright © 2016 Molina. All rights reserved.
//

import Foundation

public protocol JSONRepresentable {
    var JSONRepresentation: Any { get }
}
public protocol JSONSerializable: JSONRepresentable {}

extension JSONSerializable {
    public var JSONRepresentation: Any {
        var representation = [String: Any]()

        for case let (label?, value) in Mirror(reflecting: self).children {
            switch value {
            case let value as JSONRepresentable:
                representation[label] = value.JSONRepresentation

            case let value as NSObject:
                representation[label] = value

            default:
                // Ignore any unserializable properties
                break
            }
        }

        return representation
    }
    public func toJSONString() -> String? {
        let representation = JSONRepresentation
        guard JSONSerialization.isValidJSONObject(representation) else { return nil }
        do {
            let data = try JSONSerialization.data(withJSONObject: representation, options: [])
            return String(data: data, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }

    public func toJSONObject() -> Any {
        return JSONRepresentation
    }
}
