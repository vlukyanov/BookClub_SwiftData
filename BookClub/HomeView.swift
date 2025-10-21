//
//  ContentView.swift
//  BookClub
//
//  Created by vlukyanov on 12/6/21.
//

import SwiftUI



struct HomeView: View {
     var bookClubViewModel:  BookClubView.BookClubViewModel

    
//    init(bookClubViewModel: BookClubView.BookClubViewModel = .init()) {
//        _bookClubViewModel = ObservedObject(wrappedValue: bookClubViewModel)
//        bookClubViewModel.bookClubViewState = BookClubViewState.login
//        bookClubViewModel.activeBook = nil
//    }
    
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoggedIn: Bool = false
    @State var tapCount: Int = 0
    @FocusState private var emailFieldIsFocused: Bool
    
    @State var isShowHint = true
  
 

    var body: some View {
     

                Text("Welcome To The BookClub!").font(.largeTitle)
                
                Spacer()
                HStack(alignment: .bottom, spacing: 2){

                    VStack(alignment: .center , spacing: 2){
                        //Text("All Books").font(.title)
                        Text("Total count is: \(bookClubViewModel.books.count)").font(.footnote)
                    }
                }
                //NavigationView {
                ScrollView{
                    LazyVGrid(columns: [GridItem()], spacing: 2){
                        ForEach(bookClubViewModel.books) {bookItem in
                            BookListItemView(book:bookItem, deleteBookAction: bookClubViewModel.deleteBook, updateBookAction: bookClubViewModel.updateBook, ratingValueChangedAction: bookClubViewModel.onRatingChanged).onTapGesture {
                                tapCount += 1
                                if tapCount > 1 {
                                    tapCount = 0
                                    bookClubViewModel.activeBook = bookItem
                                    bookClubViewModel.bookClubViewState = BookClubViewState.update
                                }
                                    
                            }
                            }
                    }.padding(.top)
                }//.onAppear(perform: bookClubViewModel.getBooks)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .trailing, spacing: 0){
                Button("Add")
                {
                    bookClubViewModel.bookClubViewState = BookClubViewState.add
                }
                Button("❔") {
                    isShowHint = true
                }.foregroundColor(.black)
  
                        
                        }
    }
}








struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        @EnvironmentObject var dataService: AppDataService
        
        let bookClubViewModel = BookClubView.BookClubViewModel(dataService: dataService)
        //let addUpdateViewModel = AddUpdateViewModel(bookModel: bookClubViewModel.bookModel)
        let bookModel = BookModel()
        bookModel.author = "TestAuthor1"
        bookModel.title = "TestTitle1"
        bookModel.isbn = "ISBN123"
        bookModel.id = 1
        bookClubViewModel.books = [bookModel]
        
        return HomeView(bookClubViewModel: bookClubViewModel)
    }
}
