//
//  File.swift
//  BookClub
//
//  Created by vlukyanov on 10/1/25.
//

import Foundation
extension Book{
    static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
    static let lastMoth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now)!
    static var sampleBooks: [Book] {
        [
            Book(title: "1984", author: "George Orwell"),
            Book(title: "The Great Gatsby",
                 author: "F. Scott Fitzgerald",
                 dateAdded: lastWeek,
                 dateStarted: Date.now,
                 status: Status.inProgress,
                 recommendedBy: "Pappa"
                ),
            Book(title: "Pride and Prejudice",
                 author: "Jane Austen",
                 dateAdded: lastMoth,
                 dateStarted: lastWeek,
                 synopsis: "SwiftData tutorial using book club example https://www.youtube.com/watch?v=tZq4mvqH9Fg",
                 rating: 5,
                 status: Status.completed,
                 recommendedBy: "Nika"
                ),
            Book(title: "Pride and Prejudice",
                 author: "Jane Austen",
                 dateAdded: lastMoth,
                 dateStarted: lastWeek,
                 synopsis: "SwiftData tutorial using book club example https://www.youtube.com/watch?v=tZq4mvqH9Fg",
                 rating: 5,
                 status: Status.completed,
                ),
            Book(title: "Pride and Prejudice",
                 author: "Jane Austen",
                 dateAdded: lastMoth,
                 dateStarted: lastWeek,
                 synopsis: "SwiftData tutorial using book club example https://www.youtube.com/watch?v=tZq4mvqH9Fg",
                 rating: 5,
                 status: Status.completed,
                 recommendedBy: "God"
                ),
            Book(title: "Pride and Prejudice",
                 author: "Jane Austen",
                 dateAdded: lastMoth,
                 dateStarted: lastWeek,
                 synopsis: "SwiftData tutorial using book club example https://www.youtube.com/watch?v=tZq4mvqH9Fg",
                 rating: 5,
                 status: Status.completed
                ),
            Book(title: "Pride and Prejudice1",
                 author: "Jane Austen",
                 dateAdded: lastMoth,
                 dateStarted: lastWeek,
                 synopsis: "SwiftData tutorial using book club example https://www.youtube.com/watch?v=tZq4mvqH9Fg",
                 rating: 5,
                 status: Status.completed
                ),
            Book(title: "Pride and Prejudice2",
                 author: "Jane Austen",
                 dateAdded: lastMoth,
                 dateStarted: lastWeek,
                 synopsis: "SwiftData tutorial using book club example https://www.youtube.com/watch?v=tZq4mvqH9Fg",
                 rating: 5,
                 status: Status.completed
                ),
            Book(title: "Pride and Prejudice3",
                 author: "Jane Austen",
                 dateAdded: lastMoth,
                 dateStarted: lastWeek,
                 synopsis: "SwiftData tutorial using book club example https://www.youtube.com/watch?v=tZq4mvqH9Fg",
                 rating: 5,
                 status: Status.completed
                ),
            Book(title: "Pride and Prejudice4",
                 author: "Jane Austen",
                 dateAdded: lastMoth,
                 dateStarted: lastWeek,
                 synopsis: "SwiftData tutorial using book club example https://www.youtube.com/watch?v=tZq4mvqH9Fg",
                 rating: 5,
                 status: Status.completed
                ),
            
        ]
    }
}
