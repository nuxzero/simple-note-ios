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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        note = Note(
            id:Int.random(in: 1..<1000),
            title: titleTextField.text ?? "",
            note: noteTextField.text ?? "",
            author: "",
            image: "",
            createdAt: Date()
        )
        noteService.addNote(note!)
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            print("The save button was not pressed, cancelling")
            return
        }
        
        note = Note(
            id:Int.random(in: 1..<1000),
            title: titleTextField.text ?? "",
            note: noteTextField.text ?? "",
            author: "",
            image: "",
            createdAt: Date()
        )
        
        noteService.addNote(note!)
    }
    
}

protocol NoteFormDelegate {
    func noteFormSaved()
    func noteFormCancelled()
}
