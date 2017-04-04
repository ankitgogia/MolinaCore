//
//  Int.swift
//  Swift extensions
//
//  Created by Anatoliy Voropay on 5/7/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import Foundation

public extension Int {
    
    // MARK: Working with numbers
    
    /**
        :returns: *true* if self is even number
    */
    public var isEven: Bool {
        return ( self % 2 == 0 )
    }
    
    /**
        :returns: *true* if self is odd number
    */
    public var isOdd: Bool {
        return ( self % 2 != 0 )
    }
    
    /**
        :returns: *true* if self is positive number
    */
    public var isPositive: Bool {
        return ( self > 0 )
    }
    
    /**
        :returns: *true* if self is negative number
    */
    public var isNegative: Bool {
        return ( self < 0 )
    }
    
    /**
        :returns: *true* if self is zero
    */
    public var isZero: Bool {
        return ( self == 0 )
    }
    
    /**
        :returns: *true* if self is positive or zero
    */
    public var isPOZ: Bool {
        return ( self.isPositive || self.isZero )
    }
    
    /**
        :returns: cast self to Double
    */
    public func double() -> Double {
        return Double(self)
    }
    
    /**
        :returns: cast self to Float
    */
    public func float() -> Float {
        return Float(self)
    }
    
    // MARK: Useful
    
    /**
        This method will repeat *closure* n times. Possible way of usage:
    
            12.times { ... do something ... }
    
        :param: closure is a given code that will be invoked
    */
    public func times(_ closure: () -> ()) {
        for _ in 0 ..< self {
            closure()
        }
    }
}
