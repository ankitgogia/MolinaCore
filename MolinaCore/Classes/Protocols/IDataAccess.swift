//
//  Datastore.swift
//  ResearchKit-Demo-1
//
//  Created by Jaren Hamblin on 8/23/16.
//  Copyright © 2016 Jaren Hamblin. All rights reserved.
//

import Foundation

public protocol IDataAccess {
    func fetch<T: AnyObject>(_ entityName: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, limit: Int?, completionHandler: ([T]) -> Void)
    func fetchFirst<T: AnyObject>(_ entityName: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completionHandler: (T?) -> Void)
    func update<T: AnyObject>(_ object: T)
    func delete<T: AnyObject>(_ object: T, completionHandler: (Bool) -> Void)
    func save(_ completionHandler: (Bool) -> Void)
}

extension IDataAccess {
    func fetch<T : AnyObject>(_ entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, limit: Int? = nil, completionHandler: ([T]) -> Void) {}
    func fetchFirst<T: AnyObject>(_ entityName: String, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, completionHandler: (T?) -> Void) {}
}
