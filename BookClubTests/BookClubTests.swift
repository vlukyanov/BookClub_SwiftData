//
//  BookClubTests.swift
//  BookClubTests
//
//  Created by vlukyanov on 12/6/21.
//

import XCTest
@testable import BookClub

class MockDataService : DataService{
    func updateBook(book: BookModel, completion: @escaping (Bool) -> Void) {
        <#code#>
    }
    
    
    func deleteBook(id: Int, completion: @escaping (Bool) -> Void) {
        <#code#>
    }
    
    func addBook(book: BookModel, completion: @escaping (Bool) -> Void) {
        <#code#>
    }
    
    
    var book = BookModel()


    func getBooks(completion: @escaping ([BookModel]) -> Void){
        book.id = 1
        book.title = "Testing"
        book.author = "TestAuth"
        book.isbn = "ISBN1234"
        completion([book])
    }
}


class BookClubTests: XCTestCase {
    
    var sot: BookClubView.BookClubViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        /// this can also work ----> sot = .init() but
        
        sot = BookClubView.BookClubViewModel(dataService: MockDataService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sot = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_getBooks() throws {
        XCTAssertTrue(sot.books.isEmpty)
        
        sot.getBooks()
        
        XCTAssertEqual(sot.books.count, 1)
    }

}
