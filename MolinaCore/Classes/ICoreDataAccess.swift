//
//  ICoreDataAccess.swift
//  BusinessPOC
//
//  Created by Jaren Hamblin on 8/25/16.
//  Copyright © 2016 Jaren Hamblin. All rights reserved.
//

import Foundation
import CoreData

public protocol ICoreDataAccess: class {
    var persistentStoreCoordinator: NSPersistentStoreCoordinator! { get }
    var managedObjectContext: NSManagedObjectContext! { get set }
    func fetch<T: NSManagedObject>(_ context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, limit: Int?) -> [T]
    func fetchFirst<T: NSManagedObject>(_ context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> T?
    func save() throws
}

extension ICoreDataAccess {
    public func fetch<T: NSManagedObject>(_ context: NSManagedObjectContext, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, limit: Int? = nil) -> [T] {
        return fetch(context, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit)
    }
    public func fetchFirst<T: NSManagedObject>(_ context: NSManagedObjectContext, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> T? {
        return fetchFirst(context, predicate: predicate, sortDescriptors: sortDescriptors)
    }
}
