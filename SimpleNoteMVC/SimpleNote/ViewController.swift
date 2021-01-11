//
//  ViewController.swift
//  SimpleNote
//
//  Created by Natthawut Haematulin on 11/1/2564 BE.
//

import UIKit

class ViewController: UIViewController {
    let noteService = NoteService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Hello world!\(noteService.retrieveNotes())")
    }


}

