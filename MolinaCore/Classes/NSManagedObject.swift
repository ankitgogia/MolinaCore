//
//  NSManagedObject.swift
//  ResearchKit-Demo-1
//
//  Created by Jaren Hamblin on 8/17/16.
//  Copyright © 2016 Jaren Hamblin. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {

    public convenience init(entityName: String, insertIntoManagedObjectContext context: NSManagedObjectContext) {
        self.init(entity: NSEntityDescription.entity(forEntityName: entityName, in: context)!, insertInto: context)
    }

    public class var entityName: String {
        let name = NSStringFromClass(self).components(separatedBy: ".").last!
        return name
    }
    
    /// Attempt to copy over any values from an object to the managedObject with the matching property name
    public func map<T>(from object: T) -> Self {
        let mirror = Mirror(reflecting: object)
        for case let (label, value) in mirror.children {
            
            if let label = label, self.responds(to: Selector(label)) {
                // Check if the type of the value is the 
                // same as the type of NSNull. This because the
                // value is Any, which can be NSNull, but is not
                // optional and cannot be nil.
                
                let isNull: Bool = value as AnyObject is NSNull
                if isNull {
                    self.setValue(nil, forKey: label)
                } else {
                    self.setValue(value, forKey: label)
                }
            }
        }
        return self
    }
}
