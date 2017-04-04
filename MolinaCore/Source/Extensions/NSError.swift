//
//  NSError.swift
//  TeslaCopilot
//
//  Created by Jaren Hamblin on 6/25/16.
//  Copyright © 2016 JariousApps. All rights reserved.
//

import Foundation

extension Error {
    public var summary: String { return "\(_domain) (\(_code))" }
}
