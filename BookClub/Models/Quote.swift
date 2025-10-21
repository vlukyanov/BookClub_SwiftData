//
//  File.swift
//  BookClub
//
//  Created by vlukyanov on 10/1/25.
//

import Foundation

import SwiftData

@Model
class Quote {
    var creationDate: Date = Date.now
    var text: String
    var page: String?
    
    
    init(
        text: String,
        page: String? = nil
        
    ) {
        self.page = page
        self.text = text
    }
    
    var book: Book?
}
