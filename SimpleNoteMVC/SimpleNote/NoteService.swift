//
//  NoteService.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 11/1/2564 BE.
//

import Foundation

class NoteService {
    
    func retrieveNotes() -> Array<Note> {
        return [
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
}
