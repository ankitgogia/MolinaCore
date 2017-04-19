//
//  UIView.swift
//  Swift extensions
//
//  Created by Anatoliy Voropay on 5/9/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: Easily get frames parameters
    
    /**
        :returns: Current view width
    */
    var width: CGFloat {
        return self.frame.size.width
    }
    
    /**
        :returns: Current view height
    */
    var height: CGFloat {
        return self.frame.size.height
    }
    
    /**
        :returns: Current view x position
    */
    var x: CGFloat {
        return self.frame.origin.x
    }

    /**
        :returns: Current view y position
    */
    var y: CGFloat {
        return self.frame.origin.y
    }
    
    /**
        :returns: Current view center x position
    */
    var centerX: CGFloat {
        return self.center.x
    }
    
    /**
        :returns: Current view center y position
    */
    var centerY: CGFloat {
        return self.center.y
    }
    
    // MARK: Easily update frames parameters
    
    /**
        Update frames width with a given value
    */
    func setWidth(_ width: CGFloat) {
        self.frame.size.width = width
    }
    
    /**
        Update frames height with a given value
    */
    func setHeight(_ height: CGFloat) {
        self.frame.size.height = height
    }
    
    /**
        Update frames origin x with a given value
    */
    func setX(_ x: CGFloat) {
        self.frame.origin.x = x
    }
    
    /**
        Update frames origin y with a given value
    */
    func setY(_ y: CGFloat) {
        self.frame.origin.y = y
    }
    
    /**
        Update frames center x with a given value
    */
    func setCenterX(_ x: CGFloat) {
        self.center.x = x
    }
    
    /**
        Update frames center y with a given value
    */
    func setCenterY(_ y: CGFloat) {
        self.center.y = y
    }

}
