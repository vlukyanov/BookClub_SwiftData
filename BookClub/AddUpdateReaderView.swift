//
//  AddUpdateReaderView.swift
//  BookClub
//
//  Created by vlukyanov on 1/3/22.
//

import SwiftUI

struct AddUpdateReaderView: View {
    
    @Binding private var viewState: BookClubViewState
    @StateObject private var addUpdateReaderViewModel: AddUpdateReaderModel

    init(viewState: Binding<BookClubViewState>, dataService: AppDataService) {
        // Provide the binding up-front so the escaping autoclosure for @StateObject
        // does not capture self during initialization.
        _addUpdateReaderViewModel = StateObject(
            wrappedValue: AddUpdateReaderModel(
                reader: ReaderModel(),
                dataService: dataService
            )
        )
        _viewState = viewState
    }

    var body: some View {

        if viewState == BookClubViewState.createProfile {
            VStack(alignment: .center){
                
                
                HStack{
                    Button("Save")
                    {
                        addUpdateReaderViewModel.AddReader() //Will Write to DB
                        viewState = BookClubViewState.login
                    }.border(Color.red, width: 2)
                    
                    Spacer()
                    
                    Button("Cancel")
                    {
                        viewState = BookClubViewState.home
                    }.border(Color.red, width: 2)
                }.border(Color.red, width: 2)
                
                Section(header: Text("Create Profile")) {
                    Spacer()
                    VStack(alignment: .leading){
                        HStack{
                            
                            
                            Label("First Name :", systemImage: "book")
                            Spacer()
                            TextField("\(addUpdateReaderViewModel.firstName)", text: $addUpdateReaderViewModel.firstName)
                        }
                        HStack{
                            Label("Last Name :", systemImage: "book")
                            Spacer()
                            TextField("\(addUpdateReaderViewModel.lastName)", text: $addUpdateReaderViewModel.lastName)
                        }
                        HStack{
                            Label("Password :", systemImage: "book")
                            Spacer()
                            TextField("\(addUpdateReaderViewModel.password)", text: $addUpdateReaderViewModel.password)
                        }
                        HStack{
                            Label("Password Confirm :", systemImage: "book")
                            Spacer()
                            TextField("\(addUpdateReaderViewModel.confirmPassword)", text: $addUpdateReaderViewModel.confirmPassword)
                        }
                    }.border(Color.red, width: 2)
                    
                }.border(Color.red, width: 2)
                Spacer()
            }.padding()
            
        } else {
            EmptyView()
        }
    }
}



//MARK: Extention

extension AddUpdateReaderView{
    class AddUpdateReaderModel: ObservableObject{
        
        let dataService: AppDataService
        
        @Published var reader: ReaderModel // Directly holding a Model instance
        @Published var firstName: String // Exposing a specific Model property
        @Published var lastName: String
        @Published var password: String
        @Published var confirmPassword: String

        // View can be initialize with some other object during dependency injection
        // ViewModel can be initialized with some ojbect like other view models as needed for subviews/widgets/structs
        init(reader: ReaderModel, dataService: AppDataService){
            self.reader = reader
            self.firstName = reader.firstName
            self.lastName = reader.lastName
            self.password = reader.password
            self.confirmPassword = ""
            self.dataService = dataService
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
            //reader1.rating = 1
            reader1.id = 1
            
            let reader5 = ReaderModel()
            
            reader5.firstName = "A-Arron"
            reader5.lastName = "Buss"
            //reader5.rating = 2
            reader5.id = 5
            let reader2 = ReaderModel()
            
            reader2.firstName = "J-Quelin"
            reader2.lastName = "Akay"
            //reader2.rating = 3
            reader2.id = 2
            let reader3 = ReaderModel()
            
            reader3.firstName = "D-Nice"
            reader3.lastName = "Fam"
            reader3.id = 3
            //reader3.rating = 5
            let reader4 = ReaderModel()
            
            reader4.firstName = "Nick"
            reader4.lastName = "Lin"
            reader4.id = 4
            //reader4.rating = 3
            readers = [reader1,reader2,reader3,reader4,reader5]
            
//            dataService.addBook(book: book){b in
//                if b {
//
//                    //self.books.remove(at: self.books.first(where: { $0.id == id} )!.id)
//                }
//            }
        }
        
        func AddReader()
        {
            // Sync edited fields back into the model before saving
            reader.firstName = firstName
            reader.lastName = lastName
            reader.password = password
            
            dataService.addReader(reader: reader){b in
                if b {
                    // handle success as needed
                }
            }
        }
        
        func Update()
        {
//            print("THE TITLE IS: \(book.title)")
//            dataService.updateBook(book: book){b in
//                if b {
//                    self.bookClubViewState = BookClubViewState.home
//                    //self.books.remove(at: self.books.first(where: { $0.id == id} )!.id)
//                }
//            }
        }
    }
}

struct AddUpdateReaderView_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateReaderView(
            viewState: Binding<BookClubViewState> .constant(.createProfile),
            dataService: AppDataService()
        )
    }
}

