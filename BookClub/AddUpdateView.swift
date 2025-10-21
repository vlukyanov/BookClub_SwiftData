//
//  AddBookView.swift
//  BookClub
//
//  Created by vlukyanov on 12/12/21.
//

import Foundation
import SwiftUI

struct AddUpdateView: View {
    @StateObject private var addUpdateViewModel:  AddUpdateViewModel
    
    
    init(bookModel: BookModel, viewState: Binding<BookClubViewState>) {
        
        _addUpdateViewModel = StateObject(wrappedValue: AddUpdateViewModel(book: bookModel, viewState: viewState))

   //     self._viewState = viewState

    }

    var body: some View {
        if(addUpdateViewModel.bookClubViewState == BookClubViewState.add){
            VStack{
                HStack{
                Button("Save")
                {
                    addUpdateViewModel.AddBook() //Will Write to DB
                    addUpdateViewModel.bookClubViewState = BookClubViewState.home // Will Trigger Reload of Books and 
                }.alignmentGuide(.trailing, computeValue: { d in
                    return d[HorizontalAlignment.trailing] + d.width / 3.0 - (d[explicit: VerticalAlignment.top] ?? 30.0)
                })
                    
                    Spacer()
                    
                    Button("Cancel")
                    {
                        addUpdateViewModel.bookClubViewState = BookClubViewState.home
                    }.alignmentGuide(.trailing, computeValue: { d in
                        return d[HorizontalAlignment.trailing] + d.width / 3.0 - (d[explicit: VerticalAlignment.top] ?? 30.0)
                    })
                    
                }.padding()
                
                BookDetailUpdateView(book: addUpdateViewModel.book, historyItems: addUpdateViewModel.historyItems)
                
            }
        }
        else if addUpdateViewModel.bookClubViewState == BookClubViewState.update {
            VStack{
                HStack{
                    Button("Save")
                    {
                        addUpdateViewModel.Update()
                        
                    }.alignmentGuide(.trailing, computeValue: { d in
                        return d[HorizontalAlignment.trailing] + d.width / 3.0 - (d[explicit: VerticalAlignment.top] ?? 30.0)
                    })
                        Spacer()
                        Button("Cancel")
                        {
                            addUpdateViewModel.bookClubViewState = BookClubViewState.view
                        }.alignmentGuide(.trailing, computeValue: { d in
                            return d[HorizontalAlignment.trailing] + d.width / 3.0 - (d[explicit: VerticalAlignment.top] ?? 30.0)
                        })
                        Spacer()
                        Button("Back to Home")
                        {
                            addUpdateViewModel.bookClubViewState = BookClubViewState.home
                        }.alignmentGuide(.trailing, computeValue: { d in
                            return d[HorizontalAlignment.trailing] + d.width / 3.0 - (d[explicit: VerticalAlignment.top] ?? 30.0)
                        })
                        
                    }.padding()
                    
                    BookDetailUpdateView(book: addUpdateViewModel.book, historyItems: addUpdateViewModel.historyItems)
            }
        }
        else if addUpdateViewModel.bookClubViewState == BookClubViewState.view
        {
            HStack{
                Button("Edit")
                {
                    withAnimation( .easeIn(duration: 2)){
                    addUpdateViewModel.bookClubViewState = BookClubViewState.update
                    }
                    
                    print("\(addUpdateViewModel.bookClubViewState)")
                }//.alignmentGuide(.trailing, computeValue: { d in
                  //  return d[HorizontalAlignment.trailing] + d.width / 3.0 - (d[explicit: VerticalAlignment.top] ?? 30.0)
                //})
                Spacer()
                Button("Back to Home")
                {
                    addUpdateViewModel.bookClubViewState = BookClubViewState.home
                }.alignmentGuide(.trailing, computeValue: { d in
                    return d[HorizontalAlignment.trailing] + d.width / 3.0 - (d[explicit: VerticalAlignment.top] ?? 30.0)
                })
            }.padding()
                
            BookDetailView(book: addUpdateViewModel.book, historyItems: addUpdateViewModel.historyItems)
                
        }
    }
}

//MARK: Extention

extension AddUpdateView{
    class AddUpdateViewModel: ObservableObject{
        //@Published var books = [BookModel]()

        @ObservedObject var book : BookModel
        @EnvironmentObject var dataService: AppDataService
        @Binding var bookClubViewState: BookClubViewState
        @Published var historyItems = [ReaderModel]()
        //var isDoneAction: Bool
        //var isAdding: Bool

        //TODO: Have this AppDataService() pass singleton Database instance object to initialize
        // View can be initialize with some other object during dependency injection
        // ViewModel can be initialized with some ojbect like other view models as needed for subviews/widgets/structs
        init(book: BookModel, viewState: Binding<BookClubViewState>){
            //_book = ObservedObject(wrappedValue: book)

            self.book = book
            self._bookClubViewState = viewState
            GetReadersForBook()
        }
        
        /// This function can be used to configure with something
        ///
        func configure(with something: Any)
        {
        
        }
        
        func GetReadersForBook()
        {
            //            Label("Balake", systemImage: "person")
            //            Label("A-Arron", systemImage: "person")
            //            Label("J-Quelin", systemImage: "person")
            //            Label("D-Nice", systemImage: "person")
            var readers: [ReaderModel]
            let reader1 = ReaderModel()
            
            reader1.firstName = "Balake"
            reader1.lastName = "Gay"
     
            reader1.id = 1
            
            let reader5 = ReaderModel()
            
            reader5.firstName = "A-Arron"
            reader5.lastName = "Buss"
     
            reader5.id = 5
            let reader2 = ReaderModel()
            
            reader2.firstName = "J-Quelin"
            reader2.lastName = "Akay"
         
            reader2.id = 2
            let reader3 = ReaderModel()
            
            reader3.firstName = "D-Nice"
            reader3.lastName = "Fam"
            reader3.id = 3
       
            let reader4 = ReaderModel()
            
            reader4.firstName = "Nick"
            reader4.lastName = "Lin"
            reader4.id = 4
      
            readers = [reader1,reader2,reader3,reader4,reader5]
            
            historyItems =  readers
//            dataService.addBook(book: book){b in
//                if b {
//
//                    //self.books.remove(at: self.books.first(where: { $0.id == id} )!.id)
//                }
//            }
        }
        
        func AddBook()
        {
            //var book: BookModel = BookModel()
            //book.title = title
            //book.author = author
            //book.isbn = isbn
            dataService.addBook(book: book){b in
                if b {
                    
                    //self.books.remove(at: self.books.first(where: { $0.id == id} )!.id)
                }
            }
        }
        
        func Update()
        {
            print("THE TITLE IS: \(book.title)")
            dataService.updateBook(book: book){b in
                if b {
                    self.bookClubViewState = BookClubViewState.home
                    //self.books.remove(at: self.books.first(where: { $0.id == id} )!.id)
                }
            }
        }
    }
}

struct AddUpdateViewModel_Previews: PreviewProvider {
  
    static var previews: some View {
        AddUpdateView(bookModel: BookModel(), viewState: Binding<BookClubViewState>(projectedValue: .constant(.add)))
    }
}
