//
//  NotesViewController.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 11/1/2564 BE.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let noteService = NoteService.shared
    var notes:[Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        notes = noteService.retrieveNotes()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as? NoteTableViewCell else {
            fatalError("The dequeued cell is not an instance of NoteTableViewCell.")
        }
        
        let note = notes[indexPath.row]
        
        cell.titleLabel.text = note.title
        ImageLoader.loadImage(with: cell.thumbImageView, for: note.image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = notes[indexPath.row]
        
        print(note)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(90)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes[indexPath.row]
            noteService.deleteNote(note.id)
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "ToNoteDetail" {
            guard let noteDetailViewController = segue.destination as? NoteDetailViewController else {
                fatalError("The segue is not an instance of NoteDetailViewController.")
            }
            noteDetailViewController.note = notes[tableView.indexPathForSelectedRow!.row]
        } else if segue.identifier == "ToNoteForm" {
            guard let navigationController = segue.destination as? UINavigationController else {
                fatalError("The segue is not an instance of UINavigationController.")
            }
            guard let noteFormViewController = navigationController.children[0] as? NoteFormViewController else {
                fatalError("The segue is not an instance of NoteFormViewController.")
            }
            noteFormViewController.delegate = self
        }
    }
}

extension NotesViewController: NoteFormDelegate {
    func noteFormSaved() {
        notes = noteService.retrieveNotes()
        tableView.reloadData()
    }
    
    func noteFormCancelled() {
        print("Cancelled.")
    }
}
