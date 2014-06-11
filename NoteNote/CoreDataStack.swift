//
//  ExcellentContext.swift
//  NoteNote
//
//  Created by Martin Nash on 6/6/14.
//  Copyright (c) 2014 MJN. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    var moc: NSManagedObjectContext?
    
    
    // in memory store
    convenience init() {
        self.init(storeUrl: nil)
    }
    
    init(storeUrl:NSURL?) {

        let modelUrl = NSBundle.mainBundle().URLForResource("NoteNote", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOfURL: modelUrl)
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        let storeType = storeUrl ? NSSQLiteStoreType : NSInMemoryStoreType
        
        psc.addPersistentStoreWithType(
            storeType,
            configuration: nil,
            URL: storeUrl,
            options: nil,
            error: nil
        )

        moc = NSManagedObjectContext(concurrencyType:NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        moc!.persistentStoreCoordinator = psc
    }
    
    class func regularStore() -> CoreDataStack {
        return CoreDataStack(storeUrl: CoreDataStack.storeUrl())
    }
    
    class func storeUrl() -> NSURL {
        let fm = NSFileManager.defaultManager()
        let urls = fm.URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask) as NSURL[]
        let documentDirUrl = urls[0]
        let dataDir = documentDirUrl.URLByAppendingPathComponent("NoteNote/Data")
        let sqliteUrl = dataDir.URLByAppendingPathComponent("notenote.sqlite")

        if fm.createDirectoryAtURL(dataDir, withIntermediateDirectories: true, attributes: nil, error: nil) {
            println("Created directory \(dataDir)")
        }
        

        if fm.fileExistsAtPath(sqliteUrl.path) {
            println("File exists")

        } else {
            NSData().writeToURL(sqliteUrl, atomically: true)

        }
        
        return sqliteUrl
    }
    
}

    

