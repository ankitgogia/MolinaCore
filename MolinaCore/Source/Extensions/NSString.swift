//
//  NSString.swift
//  Swift extensions
//
//  Created by Anatoliy Voropay on 5/7/15.
//  Copyright (c) 2015 Smartarium.com. All rights reserved.
//

import Foundation

public extension NSString {
    
    /** 
        Returns *true* if email is valid. This validation is checking string for matching regexp only. 
        It will not check domain extensions. It's not guarantee you that it's a real email address also.
    
        :param: email is a string that we will check as email correctness
    
        :returns: *true* if it's valid email and *false* otherwise
    */
    public class func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        
        return result
    }
}
