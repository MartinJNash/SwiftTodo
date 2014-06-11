//
//  AppDelegate.swift
//  NoteNote
//
//  Created by Martin Nash on 6/6/14.
//  Copyright (c) 2014 MJN. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        let fm = NSFileManager.defaultManager()
        let urls = fm.URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask) as NSURL[]
        let documentDirUrl = urls[0]
        let dataDir = documentDirUrl.URLByAppendingPathComponent("NoteNote/Data")
        let sqliteUrl = dataDir.URLByAppendingPathComponent("notenote.sqlite")
        
        println(sqliteUrl.URLByDeletingLastPathComponent == dataDir)
        
        return true
    }

}

