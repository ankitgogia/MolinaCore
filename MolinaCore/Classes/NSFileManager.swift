//
//  NSFileManager.swift
//  Swift extensions
//
//  Created by Anatoliy Voropay on 5/9/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import Foundation

public extension FileManager {
    
    /**
        Will return size of a file in given path. If file does not exists will return 0.
    
        :param: path is a file path string
    
        :returns: File size
    */
    public func fileSizeAtPath(_ path: String) -> Int {
        var size: UInt64 = 0
        let attributes: NSDictionary? = try! FileManager.default.attributesOfItem(atPath: path) as NSDictionary?
        if let dict = attributes {
            size = dict.fileSize()
            return Int(size)
        }
        return 0
    }
}
