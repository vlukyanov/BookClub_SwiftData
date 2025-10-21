//
//  DAL.swift
//  BookClub
//
//  Created by vlukyanov on 12/7/21.
//

import Foundation
import SwiftUI
//#if SQLITE_SWIFT_STANDALONE
//import sqlite3
//#elseif SQLITE_SWIFT_SQLCIPHER
//import SQLCipher
//#elseif os(Linux)
//import CSQLite
//#else
//import SQLite3
//#endif

import SQLite3


class DBManager
{
    static let shared = DBManager()
   
    private var db: OpaquePointer?
    static private let path : String = "BookClub.sqlite3"
    
    init()
    {
        let filePath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor:  nil, create:false).appendingPathExtension(DBManager.path)
        
        let databaseFileName = "BookClub.sqlite"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! // Documents DB directory
        let databasePathDocs = documentsDirectory.appendingPathComponent(databaseFileName).path // Path to documents DB
        let databasePathApp = filePath.path // Actual DB path
        
        let path = FileManager.default
        
        let docDb = databaseExists(atPath:databasePathDocs);
        let appDb = databaseExists(atPath:databasePathApp);
        if(appDb)
        {
            print("Database already exists will open existing DB at:  \(databasePathApp)")
        }
        else{
            print("Database DOES NOT exists and will create new DB at existing DB")
        }
        
        // This will open if DB exists or create new DB
        self.db = createDB()
        
        //self.adddbfield(sFieldName: "description", sFieldType: "TEXT", sTable: "book")
        //self.dropTable(tableName:"reader")
        //self.alterTalbeColumnType(tableName: "book", columbNameToChange: "emotion", newColumbNameType: "Integer")
        //self.adddbfield(sFieldName: "feeling", sFieldType: "TEXT", sTable: "book")
        
        self.createBookTable()
        self.dropTable(tableName: "reader")
        self.createReadersTable()
        
    }
    
    func databaseExists(atPath path: String) -> Bool {
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: path)
    }
    
    func commit() -> Bool
    {
        var errorMessage: UnsafeMutablePointer<Int8>?
        if sqlite3_exec(db, "COMMIT;", nil, nil, &errorMessage) != SQLITE_OK {
            print("Error committing transaction: \(String(cString: errorMessage!))")
            sqlite3_free(errorMessage)
            // Consider rolling back if commit fails
            sqlite3_exec(db, "ROLLBACK;", nil, nil, nil)
            return true;
        } else {
            print("Transaction committed successfully.")
            return false;
        }
    
    }
    
    func beginTransaction() -> Bool
    {
        var errorMessage: UnsafeMutablePointer<Int8>?
        if sqlite3_exec(db, "BEGIN TRANSACTION;", nil, nil, &errorMessage) != SQLITE_OK {
            print("Error beginning transaction: \(String(cString: errorMessage!))")
            sqlite3_free(errorMessage)
            return true;
        }
        else
        {
            return false;
        }
    }
    
func getEntities<T>(id:Int?) -> [T]
{
    let entities: [T] = []
    
    return entities
}


func createDB() -> OpaquePointer?{
    let filePath = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor:  nil, create:false).appendingPathExtension(DBManager.path)
    print(filePath)
    var db: OpaquePointer? = nil
    let connection = sqlite3_open(filePath.path, &db)
    if  connection != SQLITE_OK {
        print("There is an error in creating DB..error message: \(connection)")
        //print(error.localizedDescription)
        sqlite3_close(db);
        return nil
    }else{
        print("Database is created with path \(DBManager.path)")
        
        return db
        }
}

func createBookTable() {
    
    //renamedbfield(sFieldNameOld: "book", sFieldNameNew: "bookEntity", sTable: "book")
    // IF NOT EXISTS
    let query = "CREATE TABLE IF NOT EXISTS book (id Integer PRIMARY KEY AUTOINCREMENT, uuid TEXT, author TEXT, isbn TEXT, title TEXT, bookEntity TEXT, feeling Integer, description TEXT);"

    var statement: OpaquePointer? = nil
    
    if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK{
        if sqlite3_step(statement) == SQLITE_DONE{
            print("Table [book] creation DONE \(String(cString: sqlite3_errmsg(db)))")
        }else{
            print("Table creation FAILED \(String(cString: sqlite3_errmsg(db)))")
        }
    }else{
        print("TABLE Preparation FAILED \(String(cString: sqlite3_errmsg(db)))")
        
    }
}
    
    func createReadersTable() {
        
        //renamedbfield(sFieldNameOld: "book", sFieldNameNew: "bookEntity", sTable: "book")
        // IF NOT EXISTS
        let query = "CREATE TABLE IF NOT EXISTS reader (id Integer PRIMARY KEY AUTOINCREMENT, uuid TEXT, firstName TEXT NOT NULL, lastName TEXT NOT NULL, readerEntity TEXT, password TEXT NOT NULL, created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL, updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL);"
        

        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Table [reader] creation DONE \(String(cString: sqlite3_errmsg(db)))")
            }else{
                print("Table creation FAILED \(String(cString: sqlite3_errmsg(db)))")
            }
        }else{
            print("TABLE Preparation FAILED \(String(cString: sqlite3_errmsg(db)))")
            
        }
    }
    
    // Bridge Table Reader read books
    func createReaderBook() {
        
        //renamedbfield(sFieldNameOld: "book", sFieldNameNew: "bookEntity", sTable: "book")
        // IF NOT EXISTS
        let query = "CREATE TABLE IF NOT EXISTS readerBook (readerId INTEGER NOT NULL, bookId INTEGER NOT NULL, PRIMARY KEY(authorId, bookId), FOREIGN KEY(readerId) REFERENCES reader(id), FOREIGN KEY(bookId) REFERENCES book(id), rating INTEGER DEFAULT 0);"
        

        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Table [reader] creation DONE \(String(cString: sqlite3_errmsg(db)))")
            }else{
                print("Table creation FAILED \(String(cString: sqlite3_errmsg(db)))")
            }
        }else{
            print("TABLE Preparation FAILED \(String(cString: sqlite3_errmsg(db)))")
            
        }
    }
    
    
    func dropTable(tableName: String) {
        
        //renamedbfield(sFieldNameOld: "book", sFieldNameNew: "bookEntity", sTable: "book")
        // IF NOT EXISTS
        let query = "DROP TABLE \(tableName);"

        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Table dropped creation DONE")
            }else{
                print("Table \(tableName) drop FAILED")
            }
        }else{
            print("TABLE Preparation FAILED")
            
        }
    }
    
    func insertBook(uuid: String, author: String, isbn: String, title: String, bookEntity: [BookModel], feeling:Int, description:String) -> Bool{
        let query = "INSERT INTO book (uuid, author, isbn, title, bookEntity, feeling, description) VALUES (?, ?, ?, ?, ?, ?, ?);"
        
        print("DATA INSERTED: \(uuid): String, \(author): String, \(isbn): String, \(title): String")

        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            //sqlite3_bind_int(statement, 1, Int32(id))
            sqlite3_bind_text(statement, 1, (uuid as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (author as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (isbn as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (title as NSString).utf8String, -1, nil)
           
            
            let data = try! JSONEncoder().encode(bookEntity)
            let bookEntity = String(data: data, encoding:  .utf8)
            sqlite3_bind_text(statement, 5, bookEntity, -1, nil)
            sqlite3_bind_int(statement, 6, (Int32(feeling)))
            sqlite3_bind_text(statement, 7, (title as NSString).utf8String, -1, nil)
            
       
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Data inserted DONE")
            }else{
                print("Data NOT inserted FAILED \(String(cString: sqlite3_errmsg(db)!))")
            }
            sqlite3_reset(statement)
        }else{
            print("Query syntax is incorrect \(String(cString: sqlite3_errmsg(db)!))")
            
        }
       // sqlite3_close(statement)
        
        return true
    }
    
    func updateBook(id: Int, uuid: String, author: String, isbn: String, title: String, bookEntity: [BookModel], feeling:Int, description: String) -> Bool{
        let query = "UPDATE book SET uuid = ?, author = ?, isbn = ?, title = ?, bookEntity = ?, feeling = ?, description = ? WHERE id = ?;"
        
        print("DATA updated: \(uuid): String, \(author): String, \(isbn): String, \(title): String, \(feeling): String, \(description): String")
        print("UPDATE book SET uuid = \(uuid), author = \(author), isbn = \(isbn), title = \(title), bookEntity = \(bookEntity), feeling = \(feeling), description = \(description) WHERE id = \(id);")
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            //sqlite3_bind_int(statement, 1, Int32(id))
            sqlite3_bind_text(statement, 1, (uuid as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (author as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (isbn as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (title as NSString).utf8String, -1, nil)
           
            
            let data = try! JSONEncoder().encode(bookEntity)
            let bookEntity = String(data: data, encoding:  .utf8)
            sqlite3_bind_text(statement, 5, bookEntity, -1, nil)
            
            sqlite3_bind_int(statement, 6, (Int32(feeling)))
            sqlite3_bind_text(statement, 7, (description as NSString).utf8String, -1, nil)
            
            sqlite3_bind_int(statement, 8, (Int32(id)))
            
       
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Data update DONE")
            }else{
                print("Data NOT update FAILED \(String(cString: sqlite3_errmsg(db)!))")
            }
            sqlite3_reset(statement)
        }else{
            print("Query syntax is incorrect \(String(cString: sqlite3_errmsg(db)!))")
            
        }
       // sqlite3_close(statement)
        
        return true
    }
    
    func deleteBook(id: Int) -> Bool{
        let query = "DELETE FROM book WHERE ID = \(id);"
        
        print("DATA DELETED: \(id)")

        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{

       
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Data delete DONE")
            }else{
                print("Data NOT deleted and FAILED \(String(cString: sqlite3_errmsg(db)!))")
            }
            sqlite3_reset(statement)
        }else{
            print("Query syntax is incorrect")
            
        }
        sqlite3_close(statement)
        
        return true
    }
    
    func selectBooks(id: Int?) -> [BookModel]{
        var list: [BookModel] = []
        
        let query = "SELECT id, uuid, author, isbn, title, bookEntity, feeling, description FROM book order by id desc;"
        //print(id)
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            while sqlite3_step(statement) == SQLITE_ROW{
                let id = Int(sqlite3_column_int(statement, 0))
                let uuid = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                let author = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                let isbn = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                let title = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                let bookItem = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                let feeling = Int(sqlite3_column_int(statement, 6))
                
                
                let model = BookModel()
                
                let unsafePointer = UnsafePointer<UInt8>(sqlite3_column_text(statement, 7)) //Note: UInt8 represents optionnal binding
                if unsafePointer != nil{
                    model.description = String(describing: String(cString: unsafePointer!))
                }
                
                //let description = String(cString: sqlite3_column_text(statement, 7))
                
               
                //let feeling: String? = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                print("This is BOOOOK \(title)")
                print("This is BOOOOK \(uuid)")
                
                model.id = id
                model.title = title
                model.author = author
                model.isbn = isbn
                model.feeling = feeling
                //model.description = description
                
                //model.uuid: uuid
               // print("\(id) --- \(uuid) --- \(author) --- \(isbn) ---\(title) ----- \(book)")
                //let data = try! JSONDecoder().decode([BookModel].self, from: book.data(using: .utf8)!)
                
                
                //model.bookEntity = data
                
                list.append(model)
                //print(list)
            }
        }
        print("LIST COUNT FROM DB: \(list.count)")
        return list
    }
    
    func adddbfield(sFieldName:String, sFieldType: String, sTable:String) -> Bool
    {
        var bReturn:Bool = false;
        let sSQL="ALTER TABLE " + sTable + " ADD COLUMN " + sFieldName + " \(sFieldType);"//" INTEGER DEFAULT -1";
        var statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, sSQL, -1, &statement, nil) != SQLITE_OK
        {
            print("Failed to prepare statement")
        }
        else
        {
            if sqlite3_step(statement) == SQLITE_DONE
            {
               print("field " + sFieldName + " added  to  " + sTable);
            }
            sqlite3_finalize(statement);
            bReturn=true;
        }
        return bReturn;
    }
    
    func renamedbfield(sFieldNameOld:String, sFieldNameNew:String, sTable:String) -> Bool
    {
        var bReturn:Bool = false;
        let sSQL="ALTER TABLE " + sTable + " RENAME COLUMN " + sFieldNameOld + " TO " + sFieldNameNew;
        var statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, sSQL, -1, &statement, nil) != SQLITE_OK
        {
            print("Failed to prepare statement")
        }
        else
        {
            if sqlite3_step(statement) == SQLITE_DONE
            {
               //print("field " + sFieldName + " added  to  " + sTable);
            }
            sqlite3_finalize(statement);
            bReturn=true;
        }
        return bReturn;
    }
    
    func alterTalbeColumnType(tableName: String, columbNameToChange: String, newColumbNameType: String) -> Bool{
        ///ALTER TABLE table_name
        //ALTER COLUMN column_name new_data_type(size);
        var bReturn:Bool = false;
        let sSQL="ALTER TABLE " + tableName + " ALTER COLUMN " + columbNameToChange + " " + newColumbNameType + ";";
        var statement:OpaquePointer? = nil
        if sqlite3_prepare_v2(db, sSQL, -1, &statement, nil) != SQLITE_OK
        {
            print("Failed to prepare statement")
        }
        else
        {
            if sqlite3_step(statement) == SQLITE_DONE
            {
               //print("field " + sFieldName + " added  to  " + sTable);
            }
            sqlite3_finalize(statement);
            bReturn=true;
        }
        return bReturn;
    }
    
    func getReaderInfo(lastName: String) -> ReaderModel?{
        let reader = ReaderModel()
        
        let query = "SELECT id, uuid, lastName, firstName, createdDate, readerEntity, password FROM reader where lastName= \(lastName);"
        //print(id)
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_ROW{
                reader.id = Int(sqlite3_column_int(statement, 0))
                reader.uuid = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                reader.lastName = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                reader.firstName = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                //reader.readerEntity = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                reader.password = String(describing: String(cString: sqlite3_column_text(statement, 5)))
            }
            else{
                print("Rows returned is nil \(String(cString: sqlite3_errmsg(db)!))")
                return nil
            }
        }
        else{
            print("Readers table statement error: \(String(cString: sqlite3_errmsg(db)!))")
        }
        return reader
    }
    
    func insertReader(uuid: String, lastName: String, firstName: String, reader: [ReaderModel], password:String) -> Bool{
        let query = "INSERT INTO reader (uuid, lastName, firstName, readerEntity, password) VALUES (?, ?, ?, ?, ?);"
        
        print("DATA INSERTED: \(uuid): String, \(uuid): String, \(lastName): String, \(firstName): String")

        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            //sqlite3_bind_int(statement, 1, Int32(id))
            sqlite3_bind_text(statement, 1, (uuid as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (lastName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (firstName as NSString).utf8String, -1, nil)

            let data = try! JSONEncoder().encode(reader)
            let readerEntity = String(data: data, encoding:  .utf8)
            let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)
            
            sqlite3_bind_text(statement, 4, readerEntity, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(statement, 5, (password as NSString).utf8String, -1, nil)
            
            DBManager.shared.beginTransaction()
            if sqlite3_step(statement) == SQLITE_DONE{
                print("Data [reader] inserted DONE")
                DBManager.shared.commit()
            }else{
                print("Data NOT inserted FAILED \(String(cString: sqlite3_errmsg(db)!))")
            }
            sqlite3_reset(statement)
        }else{
            print("Query syntax is incorrect \(String(cString: sqlite3_errmsg(db)!))")
            
        }
       // sqlite3_close(statement)
        
        return true
    }

    
//    private var users: Table!
//
//    private var id: Expression<Int64>
//
//    private var id: Expression<Int64>
//    private var name: Expression<String>
//    private var email: Expression<String>
//    private var age: Expression<Int64>
    
//    init()
//    {
//
//    }
//
//    do{
//        let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
//        db = try Connection("\(path)/my_users.sqlite3")
//
//        users = Table("users")
//
//        id = Expression<Int64>("id")
//        name = Expression<String>("name")
//        email = Expression<String>("email")
//        age = Expression<Int64>("age")
//
//        if(!UserDefaults.standard.bool(forKey: "is_db_created")){
//            try do.run(users.create { (t)
//                {
//                    t.column(id, primaryKey: true)
//                    t.column(name)
//                    t.column(email, unique: true)
//                    t.column(age)
//
//
//                })
//
//                UserDefaults.standard.set(true, forKey: "is_db_created")
//
//            }catch{
//                print(error.localizedDescription)
//            }
//       }
//    }
}

