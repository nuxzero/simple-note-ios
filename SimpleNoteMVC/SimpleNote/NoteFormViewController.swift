//
//  NoteFormViewController.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 13/1/2564 BE.
//

import UIKit

class NoteFormViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    var delegate: NoteFormDelegate?
    
    private let noteService = NoteService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        let note = Note(
            id:Int.random(in: 1..<1000),
            title: titleTextField.text ?? "",
            note: noteTextField.text ?? "",
            author: "",
            image: "",
            createdAt: Date()
        )
        noteService.addNote(note)
        delegate?.noteFormSaved()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.noteFormCancelled()
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol NoteFormDelegate {
    func noteFormSaved()
    func noteFormCancelled()
}
