//
//  Note.swift
//  NoteNote
//
//  Created by Martin Nash on 6/6/14.
//  Copyright (c) 2014 MJN. All rights reserved.
//

import Foundation
import CoreData

class Note: NSManagedObject {
    
    @NSManaged var content: String
    @NSManaged var read: Bool
    
    class func makeIn(moc: NSManagedObjectContext) -> Note? {
        let newObject = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext:moc) as Note
        return newObject
    }
    
    class func allIn(moc: NSManagedObjectContext) -> Note[] {
        let req = NSFetchRequest(entityName: "Note")
        req.fetchBatchSize = 20
        return moc.executeFetchRequest(req, error:nil) as Note[]
    }
    
    override func awakeFromInsert() {
        content = ""
    }
}