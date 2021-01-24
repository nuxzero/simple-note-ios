//
//  Note.swift
//  SimpleNoteMVC
//
//  Created by Natthawut Haematulin on 11/1/2564 BE.
//

import Foundation

struct Note: Codable {
    var id: Int
    var title: String
    var note: String
    var author: String
    var image: String
    var createdAt: Date?
    
    init(from decoder: Decoder) throws {
        let containers = try decoder.container(keyedBy: CodingKeys.self)
        id = try containers.decode(Int.self, forKey: .id)
        title = try containers.decode(String.self, forKey: .title)
        note = try containers.decode(String.self, forKey: .note)
        author = try containers.decode(String.self, forKey: .author)
        image = try containers.decode(String.self, forKey: .image)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        // Use format appropriate to your JSON String.  This is for ISO-8601
        // You MUST account for the milliseconds even if you don't want them
        // or it won't parse properly
        dateFormatter.dateFormat = "yy-MM-dd'T'HH:mm:ssZ"
        
        let dateStr = try containers.decode(String.self, forKey: .createdAt)
        createdAt = dateFormatter.date(from: dateStr)
    }
    
    init(id: Int, title: String, note: String, author: String, image: String, createdAt: Date) {
        self.id = id
        self.title = title
        self.note = note
        self.author = author
        self.image = image
        self.createdAt = createdAt
    }
}


 

extension Note {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case note
        case author
        case image
        case createdAt = "created_at"
    }
}

struct CreateNoteParameters: Encodable {
    var id: Int
    var title: String
    var note: String
    var author: String
    var image: String
    var createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case note
        case author
        case image
        case createdAt = "created_at"
    }
}

struct GetNoteListRequest {
    
}

extension Note {
    static func getNoteListRequest() -> Request<[Note]> {
        return Request<[Note]>(path: "notes", method: .get, body: nil)
    }
    
    static func getNoteRequest(_ id: Int) -> Request<Note> {
        return Request<Note>(path: "notes/\(id)", method: .get, body: nil)
    }
    
    static func createNoteRequest(_ parameters: CreateNoteParameters) -> Request<Note> {
        return Request<Note>(path: "notes", method: .post, body: parameters)
    }
}
