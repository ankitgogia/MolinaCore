//
//  UIAlertController.swift
//  MolinaCore
//
//  Created by Jaren Hamblin on 2/23/17.
//  Copyright © 2017 Molina. All rights reserved.
//

import UIKit


extension UIAlertController {

    /// A custom UIAlertController that displays a title and a UIActivityIndicatorView (Note: Title should be limited to one line of text only)
    public static func activityAlert(titled title: String? = nil) -> UIAlertController {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        //create an activity indicator
        let indicator = UIActivityIndicatorView(frame: alert.view.bounds)
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let title = title {
            alert.title = title
            alert.message = "\n\n"
            indicator.center = CGPoint(x: alert.view.center.x, y: alert.view.center.y + 16)
        } else {
            alert.title = ""
            indicator.center = alert.view.center
        }
        
        indicator.color = UIColor.black
        
        //add the activity indicator as a subview of the alert controller's view
        alert.view.addSubview(indicator)
        
        indicator.isUserInteractionEnabled = false // required otherwise if there buttons in the UIAlertController you will not be able to press them
        indicator.startAnimating()
        
        return alert
    }
    
    
    
    // MARK: - Helper methods
    
    /// Add an action to an instance of alert (Convenience method for instantiating a UIAlertAction and calling addAction)
    public func addAction(title: String?, style: UIAlertActionStyle = UIAlertActionStyle.default, handler: ((UIAlertAction) -> Void)? = nil) {
        addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
    
    /// Set the popover controller source view, source rect and the permitted arrow directions
    public func setPopoverSource(sender: Any, permittedArrowDirections: UIPopoverArrowDirection = UIPopoverArrowDirection.any) {
        if let popoverController = self.popoverPresentationController, let view = sender as? UIView {
            popoverController.sourceView = view
            popoverController.sourceRect = view.bounds
            popoverController.permittedArrowDirections = permittedArrowDirections
        }
    }
}
