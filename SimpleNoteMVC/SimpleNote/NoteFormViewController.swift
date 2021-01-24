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
            addNote()
        } else {
            updateNote()
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.noteFormCancelled()
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField {
            
        }
    }
    
    private func addNote() {
        let id = Int.random(in: 1..<1000)
        let parameters = NoteParameters(
            id: id,
            title: titleTextField.text ?? "",
            note: noteTextField.text ?? "",
            author: "John Doe",
            image: "https://picsum.photos/id/\(id)/800/1200",
            createdAt: Date()
        )
        noteService.addNote(parameters) { result in
            switch result {
            case .success(_):
                print("Add note success.")
            case .failure(let error):
                print(error)
            }
            self.delegate?.noteFormSaved()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func updateNote() {
        guard let note = note else {
            fatalError("Note must not be nil.")
        }
        
        let parameters = NoteParameters(
            id: note.id,
            title: titleTextField.text ?? "",
            note: noteTextField.text ?? "",
            author: "John Doe",
            image: note.image,
            createdAt: Date()
        )
        
        noteService.updateNote(parameters) { result in
            switch result {
            case .success(_):
                print("Update note success.")
            case .failure(let error):
                print(error)
            }
            self.delegate?.noteFormSaved()
            self.dismiss(animated: true, completion: nil)
        }
    }
}

protocol NoteFormDelegate {
    func noteFormSaved()
    func noteFormCancelled()
}
