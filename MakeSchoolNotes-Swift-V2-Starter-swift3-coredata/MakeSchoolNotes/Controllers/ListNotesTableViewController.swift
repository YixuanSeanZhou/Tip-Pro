//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    var notes = [Note]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDataHelper.retrieveNotes()
        self.navigationController?.navigationBar.barTintColor = .yellow
    }
    
    
    //    Lines of the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    //    tableView for the lables
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell

        let row = indexPath.row
        print(notes.count)
        let note = notes[notes.count-row-1]

        cell.noteTitleLable.text = note.title
        //convert the time to String and store as the time lable
        cell.noteModificationTimeLable.text = note.modificationTime?.convertToString()
        cell.abbr.text = note.content
 
        return cell
    }
    // Function for calling the "+" or taping the note line to tranfer the page from the List page to the Note page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "displayNote" {
                print("Table view cell tapped")
                
                // Find the line that taped by the user
                let indexPath = tableView.indexPathForSelectedRow!
                // call the note of that row in the notes array
                let note = notes[notes.count-indexPath.row-1]
                // make a instance of DisplayNoteViewController
                let displayNoteViewController = segue.destination as! DisplayNoteViewController
                // Read the notes array, Store in the note array
                displayNoteViewController.note = note
                
            } else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
    // unwind segue
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue) {
         self.notes = CoreDataHelper.retrieveNotes()
    }
    //delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //adding a new way of using by deleting
        if editingStyle == .delete {
            CoreDataHelper.deletNote(note: notes[notes.count-indexPath.row-1])
            notes = CoreDataHelper.retrieveNotes()
        }
    }
    
    
}
