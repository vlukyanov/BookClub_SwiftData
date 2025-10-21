//
//  BookDetailView.swift
//  BookClub
//
//  Created by vlukyanov on 12/22/21.
//

import Foundation
import SwiftUI


struct BookDetailView: View {
    

@ObservedObject var book: BookModel
var historyItems: [ReaderModel]
     
    //var viewState: BookClubViewState
    
    
//@Binding var viewState: BookClubViewState

    let dateFormatter = DateFormatter()
    

    func getDate() -> String
    {
        
        return dateFormatter.string(from: Date.now)
        
    }
    
    
var body: some View {
    

    List {

        Section(header: Text("Book Details")) {
           
            HStack{
                Label("Title :", systemImage: "book")
                Spacer()
                Text("\(book.title)").padding(5)
                    .foregroundColor(.gray)
                    .background(.white)
                    .cornerRadius(4)
            }//.accessibilityElement(children: .combine)
            HStack{
                Label("Author :", systemImage: "book")
                Spacer()
                Text("\(book.author)").padding(4)
                    .foregroundColor(.gray)
                    .background(.white)
                    .cornerRadius(4)
            }//.accessibilityElement(children: .combine)
            HStack{
                Label("Rating :", systemImage: "book")
                Spacer()
                RatingPickerView(
                    rating: Binding<Int?>(get: { book.feeling }, set: { book.feeling = $0 ?? 0 }),
                    ratingValueChangedAction: nil
                )
                .disabled(true)
            }//.accessibilityElement(children: .combine)
            HStack{
                Label("Description :", systemImage: "book")
                Spacer()
                Text("\(book.description)").padding(4)
                    .foregroundColor(.gray)
                    .background(.white)
                    .cornerRadius(4)
            }//.accessibilityElement(children: .combine)
            HStack{
                Label("ISBN :", systemImage: "book")
                Spacer()
                Text("\(book.isbn)").padding(4)
                    .foregroundColor(.gray)
                    .background(.white)
                    .cornerRadius(4)
            }//.accessibilityElement(children: .combine)

        }
        Section(header: Text("Readers")) {
            ReadersListItemView(bookHistoryItems: historyItems)
                
//            HStack{
//            Label("Jessica", systemImage: "person")
//                Spacer()
//                Text(getDate())
//            }
//            Label("Balake", systemImage: "person")
//            Label("A-Arron", systemImage: "person")
//            Label("J-Quelin", systemImage: "person")
//            Label("D-Nice", systemImage: "person")
//        }
        }
    }
    }
}


//struct BookDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        
//        let bookClubViewModel = BookClubView.BookClubViewModel()
//        bookClubViewModel.bookClubViewState = BookClubViewState.view
//        //let addUpdateViewModel = AddUpdateViewModel(bookModel: bookClubViewModel.bookModel)
//        let bookModel = BookModel()
//        bookModel.author = "TestAuthor1"
//        bookModel.title = "TestTitle1"
//        bookModel.isbn = "ISBN123"
//        bookModel.id = 1
//        bookClubViewModel.books = [bookModel]
//        bookClubViewModel.activeBook = bookModel
//        return BookDetailView(book: bookClubViewModel.activeBook!, readers: [ReaderModel()])
//    }
//}
