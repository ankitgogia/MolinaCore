//
//  Fade.swift
//  MolinaCore
//
//  Created by Jaren Hamblin on 3/9/17.
//  Copyright © 2017 Molina. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
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
