//
//  NSObject.swift
//  Swift extensions
//
//  Created by Anatoliy Voropay on 5/7/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import Foundation

public extension NSObject {
    
    /** 
        This will run closure after delay. Invokation will be on main_queue.
    
        :param: delay is number of seconds to delay
    */
    @available(*, deprecated: 9.0, message: "Use DispatchQueue.global().asyncAfter")
    public func delay(_ delay: Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
}
