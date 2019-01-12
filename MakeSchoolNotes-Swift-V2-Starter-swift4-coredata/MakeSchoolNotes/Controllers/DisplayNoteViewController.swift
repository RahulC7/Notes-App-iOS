//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import CoreData


class DisplayNoteViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contextTextView: UITextView!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note{
            titleTextField.text = note.title
            contextTextView.text = note.context
        } else{
            titleTextField.text = ""
            contextTextView.text = ""
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
       
        switch identifier {
        case "save" where note != nil:
            note?.title = titleTextField.text ?? ""
            note?.context = contextTextView.text ?? ""
            CoreDataHelper.saveNote()
        case "save" where note == nil:
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? ""
            note.context = contextTextView.text ?? ""
            note.modificationTime = Date()
            CoreDataHelper.saveNote()
        case "cancel":
            print("cancel")
        default:
            print("unexpected")
        }
    }
    
}
