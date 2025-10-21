//
//  BookDetailView.swift
//  BookClub
//
//  Created by vlukyanov on 12/22/21.
//

import Foundation
import SwiftUI


struct BookDetailUpdateView: View{
    

@ObservedObject var book: BookModel
    var historyItems: [ReaderModel]

    let dateFormatter = DateFormatter()
    

    func getDate() -> String
    {
        
        return dateFormatter.string(from: Date.now)
        
    }
    
    
    var body: some View {
    //    VStack{
    //        HStack{
    //        Button("Save")
    //        {
    //            isPresentingEditView = false
    //        }.alignmentGuide(.trailing, computeValue: { d in
    //            return d[HorizontalAlignment.trailing] + d.width / 3.0 - (d[explicit: VerticalAlignment.top] ?? 30.0)
    //        })
    //
    //        Button("Cancel")
    //        {
    //            isPresentingEditView = false
    //        }.alignmentGuide(.trailing, computeValue: { d in
    //            return d[HorizontalAlignment.trailing] + d.width / 3.0 - (d[explicit: VerticalAlignment.top] ?? 30.0)
    //        })
    //        }
    //

        List {

            Section(header: Text("Book Details")) {
                HStack{
                    Label("Title :", systemImage: "book")
                    Spacer()
                    TextField("\(book.title)", text: $book.title).padding(4)
                        .foregroundColor(.gray)
                        .background(.white)
                        .cornerRadius(4)
                }
                HStack{
                    Label("Author :", systemImage: "book")
                    Spacer()
                    TextField("\(book.author)", text: $book.author).padding(4)
                        .foregroundColor(.gray)
                        .background(.white)
                        .cornerRadius(4)
                }//.accessibilityElement(children: .combine)
                HStack{
                    Label("Rating :", systemImage: "book")
                    Spacer()
                    RatingPickerView(
                        rating: Binding<Int?>(
                            get: { book.feeling },
                            set: { book.feeling = $0 ?? 0 }
                        )
                    )
                }//.accessibilityElement(children: .combine)
                HStack{
                    Label("Description :", systemImage: "book")
                    Spacer()
                    TextField("\(book.description)", text: $book.description).padding(4)
                        .foregroundColor(.gray)
                        .background(.white)
                        .cornerRadius(4)
                }//.accessibilityElement(children: .combine)
                HStack{
                    Label("ISBN :", systemImage: "book")
                    Spacer()
                    TextField("\(book.isbn)", text: $book.isbn).padding(4)
                        .foregroundColor(.gray)
                        .background(.white)
                        .cornerRadius(4)
                }//.accessibilityElement(children: .combine)

            }
            Section(header: Text("Readers")) {
                ReadersListItemView(bookHistoryItems: historyItems)
            }
        }
    
    }
}


//struct BookDetailUpdateView_Previews: PreviewProvider {
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

