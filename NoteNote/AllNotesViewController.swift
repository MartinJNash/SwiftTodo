//
//  ViewController.swift
//  NoteNote
//
//  Created by Martin Nash on 6/6/14.
//  Copyright (c) 2014 MJN. All rights reserved.
//

import UIKit

class AllNotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CreateNoteViewControllerDelegate {
                            
    @IBOutlet var tableView : UITableView
    let cdStack = CoreDataStack.regularStore()
    var notes: Note[] { return Note.allIn(cdStack.moc!) }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    {
        if let vc = segue.destinationViewController as? CreateNoteViewController {
            vc.delegate = self
            vc.moc = cdStack.moc
        }
        
        if let vc = segue.destinationViewController as? SingleNoteViewController {
            if let cell = sender as? UITableViewCell {
                vc.note = notes[tableView.indexPathForCell(cell).row]
                println("TODO single note")
                
            }
        }
    }

    
    // --- CreateNoteViewControllerDelegate ---
    func createNoteViewController(createNoteViewController: CreateNoteViewController, didCreateNote note: Note)
    {
        note.managedObjectContext.save(nil)
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    // --- UITableViewDataSource ---
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("SingleNoteCell") as UITableViewCell
        let note = notes[indexPath.row] as Note
        cell.textLabel.text = note.content
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return notes.count
    }
}

