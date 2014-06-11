//
//  CreateNoteViewController.swift
//  NoteNote
//
//  Created by Martin Nash on 6/6/14.
//  Copyright (c) 2014 MJN. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc protocol CreateNoteViewControllerDelegate {
    func createNoteViewController(createNoteViewController:CreateNoteViewController, didCreateNote note:Note)
}

class CreateNoteViewController: UIViewController {
 
    var moc: NSManagedObjectContext?
    weak var delegate: CreateNoteViewControllerDelegate?
    @IBOutlet var textView: UITextView?

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: nil) { notification in
            let endRectValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue
            let frame = endRectValue.CGRectValue()
            self.textView!.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.size.height, right: 0)
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: nil) { notification in
            self.textView!.contentInset = UIEdgeInsetsZero
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func onSave(sender: AnyObject?) {
        if let myMoc = moc {
            var note = Note.makeIn(myMoc)!
            note.content = textView!.text
            if let theDelegate = delegate {
                theDelegate.createNoteViewController(self, didCreateNote: note)
            }
        }
    }
    
    @IBAction func selfDismissed(sender: AnyObject?) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}