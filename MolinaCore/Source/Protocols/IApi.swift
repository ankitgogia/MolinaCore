//
//  IApi.swift
//  MolinaCore
//
//  Created by Jaren Hamblin on 3/6/17.
//  Copyright © 2017 Molina. All rights reserved.
//

import Foundation

public protocol IApi {
    var name: String { get }
    var urlString: String { get }
    var url: URL { get }
}
