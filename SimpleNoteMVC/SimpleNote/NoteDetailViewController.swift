//
//  NoteDetailViewController.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 13/1/2564 BE.
//

import UIKit

class NoteDetailViewController: UIViewController {

    var note: Note?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let note = note else {
            fatalError("Could not found note object.")
        }
        
        titleLabel.text = note.title
        descriptionLabel.text = note.note
    }
    
    @IBAction func editNote(_ sender: Any) {
        print("Go to note form")
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
