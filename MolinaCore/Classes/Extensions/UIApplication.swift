//
//  UIApplication.swift
//  TeslaCopilot
//
//  Created by Jaren Hamblin on 6/25/16.
//  Copyright © 2016 JariousApps. All rights reserved.
//

import Foundation
import UIKit




extension UIApplication {
    
    
    public func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        if (rootViewController == nil) { return nil }
        if (rootViewController.isKind(of: UITabBarController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        } else if (rootViewController.isKind(of: UINavigationController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
        } else if (rootViewController.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }
    
    
    
    
    
    /// Attempts to call the specified phone number. If a sender is provided, an alert will be displayed for confirmation prior to initiating the phone call. If a sender is not provided, then the call is initated immediately.
    ///
    /// - Parameters:
    ///   - phoneNumber: String?
    ///   - sender: UIViewController?
    public static func call(phoneNumber: String?, title: String? = nil, message: String? = nil, sender: UIViewController? = nil, completion: (() -> Void)? = nil) {
        
        guard let rawPhoneNumber = phoneNumber else { return }
        
        let phoneNumber = rawPhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        
        guard let phoneUrl = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneUrl) else { return }
        
        func open(url: URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        }
        
        if let viewController = sender {
            
            let title: String = title ?? rawPhoneNumber
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("common.callalert.cancel", comment: "Cancel Button"), style: UIAlertActionStyle.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: NSLocalizedString("common.callalert.call", comment: "Call Button"), style: UIAlertActionStyle.default, handler: { _ in
                completion?()
                open(url: phoneUrl)
            }))
            viewController.present(alert, animated: true, completion: nil)
            
        } else {
            completion?()
            open(url: phoneUrl)
        }
    }
}

