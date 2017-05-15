//
//  TouchIdUtility.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 12/2/16.
//  Copyright © 2016 Molina Healthcare Inc. All rights reserved.
//

import Foundation
import LocalAuthentication

public struct TouchIdUtility {

    public static let shared = TouchIdUtility()
    public let context: LAContext
    
    public init(context: LAContext = LAContext()) {
        self.context = context
    }

    public var isTouchIdSupported: Bool {
        var error: NSError?
        let isTouchIdSupported = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
        return isTouchIdSupported
    }

    public func verify(reason: String = "Authenticate with Touch ID", fallbackTitle: String = "", completion: @escaping (Bool, LAError.Code?) -> Void) {
        guard isTouchIdSupported else { return }
        
        context.localizedFallbackTitle = fallbackTitle

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
}
