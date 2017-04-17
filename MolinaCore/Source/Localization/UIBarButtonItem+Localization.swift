//
//  UIBarButtonItem+Localization.swift
//  MemberHIH
//
//  Created by Jaren Hamblin on 4/5/17.
//  Copyright © 2017 Molina Healthcare, Inc. All rights reserved.
//

import Foundation
import UIKit

public extension UIBarButtonItem {
    /**
     Update UIBarButtonItem localization conditional on if title parameter has been set
     */
    override public func updateLocalisation() {
        if self.title != nil && (self.title?.characters.count)! > 0 {
            super.updateLocalisation();
        }
    }
}
