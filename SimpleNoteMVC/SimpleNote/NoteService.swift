//
//  NoteService.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 11/1/2564 BE.
//

import Foundation

class NoteService {
    
    static let shared = NoteService()
    
    private var notes:[Note] = []
    
    init() {
        notes += [
            Note(
                id: 1,
                title: "Lorem ipsum dolor sit amet",
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                author: "John Doe",
                image: "https://images.unsplash.com/photo-1610049952124-214a528991c3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1526&q=80",
                createdAt: Date()
            ),
            Note(
                id: 2,
                title: "Lorem ipsum dolor sit amet",
                note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                author: "John Doe",
                image: "https://images.unsplash.com/photo-1610049952124-214a528991c3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1526&q=80",
                createdAt: Date()
            ),
        ]
        
    }
    
    func retrieveNotes() -> Array<Note> {
        let request = Note.getNoteListRequest()
        NetworkService.shared.send(request) { result in
            switch result {
            case .success(let data):
                print(data)
            case.failure(let error):
                print(error)
            }
        }
        return notes
    }
    
    func retrieveNote(_ id: Int) -> Note? {
        return notes.first(where: {return $0.id == id})
    }
    
    func addNote(_ note: Note) {
        notes.append(note)
    }
    
    func updateNote(_ note: Note) {
        guard let index = notes.firstIndex(where: {return $0.id == note.id}) else {
            fatalError("Index not found.")
        }
        notes.remove(at: index)
        notes.insert(note, at: index)
    }
    
    func deleteNote(_ id: Int) {
        notes.removeAll(where: {return $0.id == id})
    }
}
