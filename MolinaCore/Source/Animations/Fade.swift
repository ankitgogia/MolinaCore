//
//  Fade.swift
//  MolinaCore
//
//  Created by Jaren Hamblin on 3/9/17.
//  Copyright © 2017 Molina. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    public func shake(times: Int = 4) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = Float(times)
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.add(animation, forKey: "position")
    }
    
    public func fadeIn(withDuration duration: TimeInterval = 0.25) {
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    public func fadeOut(withDuration duration: TimeInterval = 0.25) {
        UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
}
