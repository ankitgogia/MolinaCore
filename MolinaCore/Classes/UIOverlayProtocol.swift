//
//  UIOverlayProtocol.swift
//  MolinaCore
//
//  Created by Jaren Hamblin on 3/27/17.
//  Copyright © 2017 Molina. All rights reserved.
//

import Foundation
import UIKit

fileprivate let overlayColor: UIColor = UIColor.black.withAlphaComponent(0.25)
fileprivate let animationDuration: TimeInterval = 0.25

public protocol UIOverlayProtocol: class {
    var overlay: UIView! { get set }
    /// Presents an overlay over the keyWindow
    func presentOverlay(_ animated: Bool, completion: (() -> Void)?)
    /// Dismisses an overlay over the keyWindow
    func dismissOverlay(_ animated: Bool, completion: (() -> Void)?)
}

extension UIOverlayProtocol {
    
    public func presentOverlay(_ animated: Bool, completion: (() -> Void)?) {
        
        guard let keyWindow = UIApplication.shared.keyWindow else {
            completion?()
            return
        }
        
        self.overlay = UIView(frame: keyWindow.frame)
        
        keyWindow.addSubview(overlay)
        
        self.overlay.backgroundColor = UIColor.clear
        
        let timeInterval: TimeInterval = animated ? animationDuration : 0
        
        UIView.animate(withDuration: timeInterval, animations: {
            self.overlay.backgroundColor = overlayColor
        }) { (result) in
            completion?()
        }
    }
    
    public func dismissOverlay(_ animated: Bool, completion: (() -> Void)?) {

        guard let overlay = self.overlay else {
            completion?()
            return
        }
        
        let timeInterval: TimeInterval = animated ? animationDuration : 0
        
        UIView.animate(withDuration: timeInterval, animations: { 
            overlay.isHidden = true
        }) { (result) in
            overlay.removeFromSuperview()
            self.overlay = nil
            completion?()
        }
    }
}
