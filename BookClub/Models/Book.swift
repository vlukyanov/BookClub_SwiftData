//
//  Book.swift
//  BookClub
//
//  Created by vlukyanov on 9/30/25.
//

import SwiftUI
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    @Attribute(originalName: "summary")
    var synopsis: String
    var rating: Int?
    var status: Status.RawValue
    var recommendedBy: String = ""
    // One to many
    @Relationship(deleteRule: .cascade) // Default is nullify where it will not delete children and only have set null to book id column
    var quotes: [Quote]?
    
    // Many to many
    @Relationship(inverse: \Genre.books)
    var genres: [Genre]?
    
    init(
        title: String,
        author: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        synopsis: String = "",
        rating: Int? = nil,
        status: Status = .onShelf,
        recommendedBy: String = ""
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.synopsis = synopsis
        self.rating = rating
        self.status = status.rawValue
        self.recommendedBy = recommendedBy
    }
    
    // Convenience computed property to work with the enum instead of rawValue.
    var statusEnum: Status {
        get { Status(rawValue: status) ?? .onShelf }
        set { status = newValue.rawValue }
    }
    
    var icon: Image {
        switch statusEnum {
        case .onShelf:
            return Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            return Image(systemName: "book.fill")
        case .completed:
            return Image(systemName: "books.vertical.fill")
        }
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    var id: Self {
        self
    }
    var descr: LocalizedStringResource {
        switch self {
        case .onShelf:
            "On Shelf"
        case .inProgress:
            "In Progress"
        case .completed:
            "Completed"
        }
    }
}
