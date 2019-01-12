//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by Rahul Chandra on 1/11/19.
//  Copyright © 2019 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import CoreData


struct CoreDataHelper{
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            fatalError()
        }
    let persistentContainer = appDelegate.persistentContainer
    let context = persistentContainer.viewContext
    return context
    }()
    


static func newNote() -> Note{
    let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
    
    return note
}
    
    static func saveNote() {
        do{
            try context.save()
        }
        catch let error{
            print("could not save")
        }
        
    }
    
    static func delete(note: Note){
        context.delete(note)
        saveNote()
    }
    
    static func retrieveNotes() -> [Note]{
        do{
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let results = try context.fetch(fetchRequest)
            
            return results
        }catch let error{
            print("cannot")
            return []
        }
    }
}
