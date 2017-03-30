//
//  Array.swift
//  Swift extensions
//
//  Created by Anatoliy Voropay on 5/7/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import Foundation

extension Array {
    
    // MARK: Object managing
    
    /** 
        Will return *true* if array contains object. Object should conform *Equatable* protocol.
    
        :param: object is a given object that will be compared to other objects in our array
    
        :returns: *true* is array contains object
    */
    public func contains<T>(_ object: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == object}).count > 0
    }
}
