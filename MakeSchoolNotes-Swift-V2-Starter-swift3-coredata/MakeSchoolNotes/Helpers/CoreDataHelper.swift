//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by Thomas on 2017/7/20.
//  Copyright © 2017年 MakeSchool. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    //static methods will go here
    static func newNote() -> Note {
        //insert is adding new object into the note, while 
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: managedContext) as! Note
        return note
    }
    
    static func saveNote() {
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print("Could not save \(error)")
        }
    }
    
    static func deletNote(note: Note){
        managedContext.delete(note)
        saveNote()
    }
    
    static func retrieveNotes() -> [Note]{
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        do{
            let result = try managedContext.fetch(fetchRequest)
            return result
        }
        catch let error as NSError{
            print("Could not fetch \(error)")
        }
        return[]
    }
}
