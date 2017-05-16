//
//  TouchIdUtility.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 12/2/16.
//  Copyright © 2016 Molina Healthcare Inc. All rights reserved.
//

import Foundation
import LocalAuthentication

public class TouchIdUtility {
    
    public let context: LAContext = LAContext()
    
    public init() {}

    public var isTouchIdSupported: Bool {
        var error: NSError?
        let isTouchIdSupported = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
        return isTouchIdSupported
    }

    public func verify(reason: String = "Authenticate with Touch ID", fallbackTitle: String? = nil, completion: @escaping (Bool, LAError.Code?) -> Void) {
        guard isTouchIdSupported else { return }
        
        self.context.localizedFallbackTitle = fallbackTitle == nil ? "" : fallbackTitle

        context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success: Bool, error: Error?) in
            DispatchQueue.global().asyncAfter(seconds: 0.01) {

                if let error = error as NSError?,
                    let laError = LAError.Code(rawValue: error.code) {
                        completion(false, laError)
                } else {
                    completion(success, nil)
                }
            }
        }
    }
    
    @available(iOS 9.0, *)
    public func cancelVerification() {
        self.context.invalidate()
    }
}
