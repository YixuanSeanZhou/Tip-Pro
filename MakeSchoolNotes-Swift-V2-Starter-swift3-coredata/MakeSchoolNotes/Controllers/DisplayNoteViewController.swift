//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    var note : Note?
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    @IBOutlet weak var noteContentTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // testing cancle and delete
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listNotesTableViewController = segue.destination as! ListNotesTableViewController
        if let identifier = segue.identifier {
            if identifier == "cancel" {
                print("Cancel button tapped")
            }
            //User used save
            else if identifier == "save" {
                print("Save button tapped")
                // Distinguish whether it is with things in
                let note = self.note ?? CoreDataHelper.newNote()
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text ?? ""
                note.modificationTime = Date() as NSDate
                CoreDataHelper.saveNote()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Means we are editing a exisiting note
        if let note = note {
            // call up the storage of notes
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        }
        //Means creating a new note
        else {
            // all things should be empty
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
}
