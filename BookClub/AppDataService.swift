//
//  AppDataService.swift
//  BookClub
//
//  Created by vlukyanov on 12/13/21.
//

import Foundation
import Observation
import Combine

protocol DataService : ObservableObject{
    //func getEntities<T>(completion: @escaping ([T]) -> Void)
    func getBooks(completion: @escaping ([BookModel]) -> Void)
    func deleteBook(id:Int, completion: @escaping (Bool) -> Void)
    func addBook(book:BookModel, completion: @escaping (Bool) -> Void)
    func updateBook(book:BookModel, completion: @escaping (Bool) -> Void)
    func addReader(reader:ReaderModel, completion: @escaping (Bool) -> Void)
    
    //Reader CRUD
    func getReaderInfo(lastName:String, completion: @escaping (ReaderModel?) -> Void)
}


class AppDataService: DataService, ObservableObject{
    
    func addReader(reader: ReaderModel, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            completion(
                DBManager.shared.insertReader(uuid: reader.uuid, lastName: reader.lastName, firstName: reader.firstName, reader: [reader], password: reader.password)
            )
        }
    }

    
    func getReaderInfo(lastName:String, completion: @escaping (ReaderModel?) -> Void) {
        DispatchQueue.main.async {
            completion(
                DBManager.shared.getReaderInfo(lastName:lastName)
            )
        }
    }
    
    
    
    
//    func getEntities<T>(completion: @escaping ([T]) -> Void){
//
//        DispatchQueue.main.async {
//
//            completion(
//                DBManager.shared.getEntities<BookModel>(id: nil)
//            )
//        }
//    }
    
    func getBooks(completion: @escaping ([BookModel]) -> Void){
        //Get userinfo, call validate for CRUD then getBooks else return error
        DispatchQueue.main.async {
            //BookModel.GetBooks()
//            var book1 = BookModel()
//            var book2 = BookModel()
//            var book3 = BookModel()
//            book1.id = 1
//            book2.id = 2
//            book3.id = 3
            completion(
                DBManager.shared.selectBooks(id: 0)
            )
        }
    }
    
    func deleteBook(id:Int, completion: @escaping (Bool) -> Void){
       
        //Get userinfo, call validate for CRUD then getBooks else return error
        DispatchQueue.main.async {
            //BookModel.GetBooks()
//            var book1 = BookModel()
//            var book2 = BookModel()
//            var book3 = BookModel()
//            book1.id = 1
//            book2.id = 2
//            book3.id = 3
            completion(
                DBManager.shared.deleteBook(id: id)
            )
        }
    }
    
    func addBook(book:BookModel, completion: @escaping (Bool) -> Void){
     //Get userinfo, call validate for CRUD then getBooks else return error
     DispatchQueue.main.async {
         //BookModel.GetBooks()
//            var book1 = BookModel()
//            var book2 = BookModel()
//            var book3 = BookModel()
//            book1.id = 1
//            book2.id = 2
//            book3.id = 3
         completion(
            DBManager.shared.insertBook(uuid: book.uuid,
                                        author: book.author,
                                        isbn: book.isbn,
                                        title: book.title,
                                        bookEntity: [BookModel](),
                                        feeling: book.feeling,
                                        description: book.description
                                       )
         )
     }
    }
        func updateBook(book:BookModel, completion: @escaping (Bool) -> Void){
         //Get userinfo, call validate for CRUD then getBooks else return error
         DispatchQueue.main.async {
             //BookModel.GetBooks()
    //            var book1 = BookModel()
    //            var book2 = BookModel()
    //            var book3 = BookModel()
    //            book1.id = 1
    //            book2.id = 2
    //            book3.id = 3
             completion(
                DBManager.shared.updateBook(id: book.id,
                                            uuid: book.uuid,
                                            author: book.author,
                                            isbn: book.isbn,
                                            title: book.title,
                                            bookEntity: [BookModel](),
                                            feeling: book.feeling,
                                            description: book.description
                                           )
             )
         }
     }
 
}
