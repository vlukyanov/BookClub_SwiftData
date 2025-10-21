//
//  BookModel.swift
//  BookClub
//
//  Created by vlukyanov on 12/6/21.
//

import Foundation


//protocol SCAttachmentModelProtocol{
//    var image:UIImage? {get set}
//    var anotherProperty:Int {get set}
//}
//extension SCAttachmentModelProtocol where Self: SCAttachmentUploadRequestModel{
//    var image:UIImage? {
//        set{
//            //Use associated object property to set it
//        }
//        get{
//            //Use associated object property to get it
//        }
//    }
//}
//class SCAttachmentUploadRequestModel : SCAttachmentModelProtocol, Codable{
//    var anotherProperty:Int
//}

//extension BookModel: Codable {
//
//
//}

struct AuthorModel : Codable{
    
}

//class BookObserver {
//
//    var kvoToken: NSKeyValueObservation?
//
//    func observe(bookModel: BookModel) {
//        kvoToken = bookModel.observe(\.author, options: .new) { (bookModel, change) in
//            guard let author = change.newValue else { return }
//                    print("New author is: \(author)")
//        }
//    }
//
//        deinit {
//            kvoToken?.invalidate()
//        }
//}


class BookModel :  Identifiable, Codable, ObservableObject{
//    static func == (lhs: BookModel, rhs: BookModel) -> Bool {
//        lhs.feeling == rhs.feeling
//    }
    // NSObject,
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case feeling = "Feeling"
        case title = "Title"
        case uuid = "UUID"
        case author = "Author"
        case bookEntity = "Book"
        case isbn = "Isbn"
        case description = "Description"
    }
    
//    enum CodingKeys : CodingKey{
//        case feeling, title, id, uuid, author, bookEntity
//    }
    @Published @objc var author : String
    @Published @objc var isbn : String
    @Published @objc var feeling : Int
    @Published @objc var description:  String = ""
    //let authorEntity : AuthorModel?
    @Published var bookEntity : [BookModel]?
    @objc var id: Int
    @Published @objc var uuid: String
    @Published @objc var title: String
    
    
//    {
//    willSet // "title" is ABOUT TO CHANGE
//            {
//                print("\nName WILL be set...")
//                print("from current value: \(title)")
//                print("to new value: \(newValue)\n")
//            }
//            didSet // "title" HAS CHANGED
//            {
//                print("Name WAS changed...")
//                print("from current value: \(oldValue)")
//                print("to new value: \(title)\n")
//                titleChanged = oldValue
//            }
//    }
    

    
    
    var titleChanged: String = ""
    var isbnChanged: String = ""
    var authorChanged: String = ""
    var feelingChanged: Int = 0
    
    //private(set) var books : Array<BookModel> = Array<BookModel>()
    
    init()
    {
        id = 0
        uuid = UUID.init().uuidString
        title = ""
        author = ""
        isbn =  ""
        bookEntity = nil
        feeling = 0
        //super.init()
        
        //Property Change Begin
        
        titleChanged = ""
        authorChanged = ""
        feelingChanged = 0
        isbnChanged = ""
    }
    
    func onSaveValidations()
    {
        
    }
    
    func onUpdateValidations()
    {
        
    }
    
    func onGetValidations()
    {
        
    }
    
//    mutating func update(value: Int)
//    {
//        self.feeling = value
//    }
    
    
//    func GetBooks() -> [BookModel]
//    {
//
//        //books.removeAll()
//        //books.append(contentsOf: db.selectBooks(id: 0))
//        //books = DBManager.shared.selectBooks(id: 0)
//        return DBManager.shared.selectBooks(id: 0)
//        //books.append(BookModel(title: "Bob Ass", author: "Author", isbn: "112334232", uuid:UUID.init().uuidString))
//    }
    
    
    
//    mutating func Save(book: BookModel)
//    {
//       // books.append(book)
//        insertBook(book: book)
//
//    }


    
//    func insertBook(book: BookModel)
//    {
//        let db = DBManager()
//        db.insertBook(uuid: book.uuid,  author: book.author, isbn: book.isbn, title: book.title, bookEntity: [BookModel](), feeling: book.feeling)
//    }
    
//    mutating func deleteBook(book: BookModel)
//    {
//        let b = self.books.first(where: { $0.id == book.id} )
//        let db = DBManager()
//        db.deleteBook(id: b!.id)
//        books.removeAll(where: { $0.id == book.id  })
//        
//    }
    
//    private enum CodingKeys: String, CodingKey {
//           case isbn
//       }
    
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy:  CodingKeys.self)
        try container.encode(feeling, forKey: .feeling)
        try container.encode(id, forKey: .id)
        try container.encode(author, forKey: .author)
        try container.encode(title, forKey: .title)
        try container.encode(uuid, forKey: .uuid)
        try container.encode(isbn, forKey: .isbn)
        try container.encode(description, forKey: .description)
        try container.encode(bookEntity, forKey: .bookEntity)
        //try container.decode.nestedContainer(keyedBy: CodingKeys.self, forKey: .friends)
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        uuid = try container.decode(String.self, forKey: .uuid)
        title = try container.decode(String.self, forKey: .title)
        author = try container.decode(String.self, forKey: .author)
        feeling = try container.decode(Int.self, forKey: .feeling)
        //bookEntity = try container.decode(String.self, forKey: .bookEntity)
        bookEntity  = try container.decode([BookModel].self, forKey: .bookEntity)
        //nestedContainer(keyedBy: CodingKeys.self, forKey: .feeling)
        isbn = try container.decode(String.self, forKey: .isbn)
        description = try container.decode(String.self, forKey: .description)
    }
    
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
//        try response.encode(bar, forKey: .bar)
//        try response.encode(baz, forKey: .baz)
//        var friends = response.nestedContainer(keyedBy: CodingKeys.self, forKey: .friends)
//        try friends.encode(bestFriend, forKey: .bestFriend)
//        try friends.encode(funnyGuy, forKey: .funnyGuy)
//        try friends.encode(favoriteWeirdo, forKey: .favoriteWeirdo)
//    }
//
//    let jsonString = """
//    {"Response": {
//        "Bar": true,
//        "Baz": "Hello, World!",
//        "Friends": {
//            "Best": "Nic",
//            "FunnyGuy": "Gabe",
//            "FavoriteWeirdo": "Jer"
//            }
//        }
//    }
//    """
    
//    let data = jsonString.data(using: .utf8)!
//    struct Foo: Codable {
//        // MARK: - Properties
//        let bar: Bool
//        let baz: String
//        let bestFriend: String
//        let funnyGuy: String
//        let favoriteWeirdo: String
//        // MARK: - Codable
//        // Coding Keys
//        enum CodingKeys: String, CodingKey {
//            case response = "Response"
//            case bar = "Bar"
//            case baz = "Baz"
//            case friends = "Friends"
//            case bestFriend = "Best"
//            case funnyGuy = "FunnyGuy"
//            case favoriteWeirdo = "FavoriteWeirdo"
//        }
//        // Decoding
//        init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            let response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
//            bar = try response.decode(Bool.self, forKey: .bar)
//            baz = try response.decode(String.self, forKey: .baz)
//            let friends = try response.nestedContainer(keyedBy: CodingKeys.self, forKey: .friends)
//            bestFriend = try friends.decode(String.self, forKey: .bestFriend)
//            funnyGuy = try friends.decode(String.self, forKey: .funnyGuy)
//            favoriteWeirdo = try friends.decode(String.self, forKey: .favoriteWeirdo)
//        }
//        // Encoding
//        func encode(to encoder: Encoder) throws {
//            var container = encoder.container(keyedBy: CodingKeys.self)
//            var response = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
//            try response.encode(bar, forKey: .bar)
//            try response.encode(baz, forKey: .baz)
//            var friends = response.nestedContainer(keyedBy: CodingKeys.self, forKey: .friends)
//            try friends.encode(bestFriend, forKey: .bestFriend)
//            try friends.encode(funnyGuy, forKey: .funnyGuy)
//            try friends.encode(favoriteWeirdo, forKey: .favoriteWeirdo)
//        }
//    }
//    let myFoo = try! JSONDecoder().decode(Foo.self, from: data)
//    // Initializes a Foo object from the JSON data at the top.
//    let dataToSend = try! JSONEncoder().encode(myFoo)
//    // Turns your Foo object into raw JSON data you can send back!"
    
//    required convenience public init(from decoder: Decoder) throws {
//        guard let contextUserInfoKey = CodingUserInfoKey.context,
//          let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
//          let entity = NSEntityDescription.entity(forEntityName: "Checklist", in: managedObjectContext) else {fatalError("Failed to decode Checklist")}
//
//        self.init(entity: entity, insertInto: managedObjectContext)
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        do {
//          name = try values.decode(String?.self, forKey: .name)
//          hasTestGroups = NSSet(array: try values.decode([TestGroup].self, forKey: .hasTestGroups))
//        } catch {
//          print("decoding error")
//        }
//      }
    
    ///////////
    ///
    ///guard let url = Bundle.main.url(forResource: "masterdatabase", withExtension: "json") else {fatalError("no file")}
//    do {
//      let json = try Data(contentsOf: url)
//      let decoder = JSONDecoder()
//      decoder.userInfo[CodingUserInfoKey.context!] = self.moc
//      do {
//        let subjects = try decoder.decode([Checklist].self, from: json)
//        subjects.first?.name = self.desiredChecklistName
//        subjects.first?.eventNumber = Int32(self.desiredChecklistNumber)!
//        subjects.first?.eventDate = self.desiredChecklistData
    
//    public var nameArray: [PutTheNameOfTheEntityWhichThisEntityIsrRelatedToHere] {
//            let set = nameOfTheNSSetInThisEntity as? Set<PutTheNameOfTheEntityWhichThisEntityIsrRelatedToHere> ?? []
//
//            return set.sorted {
//                // Put the sorting method you want here
//                // For example if the entity has an attribute called title then you would put this
//                $0.title < $1.title
//                // This will sort the array based on its title
//            }
//        }
        
}

