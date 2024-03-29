//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    
    var notes = [Note](){
        didSet{
            tableView.reloadData()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = CoreDataHelper.retrieveNotes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count;
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let noteToDelete = notes[indexPath.row]
            CoreDataHelper.delete(note: noteToDelete)
            notes = CoreDataHelper.retrieveNotes()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        let note = notes[indexPath.row]
        cell.noteTtitleLabel.text = note.title
        cell.noteModifiedTimeTable.text = note.modificationTime?.convertToString() ?? "unknown"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "displayNote":
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            
            let note = notes[indexPath.row]
            
            let destination = segue.destination as! DisplayNoteViewController
            
            destination.note = note
            
            print("cnote cell tapped")
        
        case "addNote":
            print("create note bar button item tapped")
        default:
            print("unexpected")
        }
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue){
        notes = CoreDataHelper.retrieveNotes()
    }
    

}

