//
//  BookModel.swift
//  BookClub
//
//  Created by vlukyanov on 12/6/21.
//

import Foundation
import Combine

class ReaderModel: Identifiable, Codable, ObservableObject {
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case firstName = "FirstName"
        case lastName = "LastName"
        case uuid = "UUID"
        case readerEntity = "Reader"
        case password = "Password"
    }
    
    @Published @objc var firstName: String
    @Published @objc var lastName: String
    @Published @objc var password: String
    @Published var readerEntity: [ReaderModel]?
    @objc var id: Int
    @Published @objc var uuid: String
    
    var books: [BookModel] = []

    init() {
        id = 0
        uuid = UUID().uuidString
        firstName = ""
        lastName = ""
        readerEntity = nil
        password = ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy:  CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(readerEntity, forKey: .readerEntity)
        try container.encode(password, forKey: .password)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        uuid = try container.decode(String.self, forKey: .uuid)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        readerEntity  = try container.decode([ReaderModel].self, forKey: .readerEntity)
        password = try container.decode(String.self, forKey: .password)
    }
}
