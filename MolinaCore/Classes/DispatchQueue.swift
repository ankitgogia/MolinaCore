//
//  DispatchQueue.swift
//  MolinaCore
//
//  Created by Jaren Hamblin on 3/23/17.
//  Copyright © 2017 Molina. All rights reserved.
//

import Foundation

extension DispatchQueue {

    public func asyncAfter(seconds: Double, _ completion: @escaping ()->()) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds) {
            completion()
        }
    }
}
