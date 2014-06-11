//
//  SingleNoteViewController.swift
//  NoteNote
//
//  Created by Martin Nash on 6/6/14.
//  Copyright (c) 2014 MJN. All rights reserved.
//

import Foundation
import UIKit

class SingleNoteViewController: UIViewController {
    var note: Note?
    
    @IBOutlet var textView: UITextView
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.textView.text = note!.content
    }
}
