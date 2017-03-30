//
//  CoreDataAccessUtility.swift
//  ResearchKit-Demo-1
//
//  Created by Jaren Hamblin on 8/16/16.
//  Copyright © 2016 Jaren Hamblin. All rights reserved.
//

import Foundation
import CoreData

open class CoreDataAccessUtility: ICoreDataAccess {

    open let sqliteFileName: String
    open let sqliteFileDirectory: String?
    open let managedObjectModelName: String
    open var persistentStoreCoordinator: NSPersistentStoreCoordinator!

    open lazy var managedObjectContext: NSManagedObjectContext! = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    public init(sqliteFileName: String, sqliteFileDirectory: String?, managedObjectModelName: String) {
        self.sqliteFileName = sqliteFileName
        self.sqliteFileDirectory = sqliteFileDirectory
        self.managedObjectModelName = managedObjectModelName

        // MARK: - Core Data Stack

        let applicationDocumentsDirectory: URL = {
            // The directory the application uses to store the Core Data store file. This code uses a directory named "com.molinahealthcare.mCareNext" in the application's documents Application Support directory.
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return urls[urls.count-1]
        }()

        let managedObjectModel: NSManagedObjectModel = {
            // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
            let modelURL = Bundle.main.url(forResource: managedObjectModelName, withExtension: "momd")!
            return NSManagedObjectModel(contentsOf: modelURL)!
        }()

        self.persistentStoreCoordinator = {
            // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
            // Create the coordinator and store
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
            let url = applicationDocumentsDirectory.appendingPathComponent("\(sqliteFileName).sqlite")
            let failureReason = "There was an error creating or loading the application's saved data."
            do {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: [NSMigratePersistentStoresAutomaticallyOption: true,
                    NSInferMappingModelAutomaticallyOption: true])
            } catch {
                // Report any error we got.
                var dict = [String: AnyObject]()
                dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
                dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
                dict[NSUnderlyingErrorKey] = error as NSError
                let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
                // Replace this with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
                abort()
            }
            return coordinator
        }()
    }

    // MARK: - DataAccessProtocol

    open func fetchFirst<T : NSManagedObject>(_ context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> T? {
        return fetch(context, predicate: predicate, sortDescriptors: sortDescriptors, limit: 0).first
    }

    open func fetch<T : NSManagedObject>(_ context: NSManagedObjectContext, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, limit: Int?) -> [T] {
        // Build request

        let request: NSFetchRequest<T> = NSFetchRequest(entityName: T.entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        if let limit = limit , limit > 0 {
            request.fetchLimit = limit
        }


        // Execute request
        var results = [T]()
        do {
            results = try context.fetch(request)
        } catch let e as NSError {
            print(e)
        }
        return results
    }

    open func save() throws {
        guard managedObjectContext.hasChanges else { return }
        try managedObjectContext.save()
    }
}
