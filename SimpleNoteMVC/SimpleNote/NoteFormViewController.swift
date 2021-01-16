//
//  NoteFormViewController.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 13/1/2564 BE.
//

import UIKit

class NoteFormViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var delegate: NoteFormDelegate?
    var note: Note?
    private let noteService = NoteService.shared
    var isNewNote = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if note != nil {
            isNewNote = false
            titleTextField.text = note?.title
            noteTextField.text = note?.note
        }
    }
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        if isNewNote {
            note = Note(
                id:Int.random(in: 1..<1000),
                title: titleTextField.text ?? "",
                note: noteTextField.text ?? "",
                author: "",
                image: "",
                createdAt: Date()
            )
            noteService.addNote(note!)
        } else {
            guard var editingNote = note else {
                fatalError("Note must not be nil.")
            }
            editingNote.title = titleTextField.text ?? ""
            editingNote.note = noteTextField.text ?? ""
            note = editingNote
            noteService.updateNote(note!)
        }
        delegate?.noteFormSaved()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.noteFormCancelled()
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField {
            
        }
    }
}

protocol NoteFormDelegate {
    func noteFormSaved()
    func noteFormCancelled()
}
