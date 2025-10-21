//
//  GenreSamples.swift
//  BookClub
//
//  Created by vlukyanov on 10/1/25.
//

import Foundation
extension Genre{
    static var sampleGenres: [Genre] {
        [
            Genre(name: "Fiction", color: "00FF00"),
            Genre(name: "Non-Fiction", color: "0000FF"),
            Genre(name: "Romance", color: "FF0000"),
            Genre(name: "Thriller", color: "000000"),
        ]
    }
}
