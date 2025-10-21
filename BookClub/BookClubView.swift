//
//  ContentView.swift
//  BookClub
//
//  Created by vlukyanov on 12/6/21.
//

import SwiftUI

struct BookClubView: View {
    @ObservedObject var bookClubViewModel:  BookClubViewModel

    init(bookClubViewModel: BookClubViewModel) {
        _bookClubViewModel = ObservedObject(wrappedValue: bookClubViewModel)
    }
    
    @State var username: String = ""
    @State var optionalPassword: String? = nil
    private var passwordBinding: Binding<String> {
            Binding<String>(
                get: { self.optionalPassword ?? "" },
                set: { self.optionalPassword = $0 }
            )
        }
    @State var tapCount: Int = 0
    @FocusState private var emailFieldIsFocused: Bool
    
    @State var isShowHint = false


    
    func validate(userName: String, password:String)
    {
        let a = userName
        let b = password
        //@EnvironmentObject var dataService: AppDataService
        //bookClubViewModel.bookClubViewState = BookClubViewState.home
    }
    
    func getReaderInfo()
    {
        //bookClubViewModel.bookClubViewState = BookClubViewState.home
    }
    var body: some View {
        if bookClubViewModel.bookClubViewState == BookClubViewState.login
        {
            VStack(alignment: .center, spacing: 20){
                
                VStack(alignment: .leading, spacing: 2){
                Text("Email")
            
            TextField(
                    "Username (email address)",
                    text: $username,
                    prompt: Text("Required")
                )
                .focused($emailFieldIsFocused)
                //.onSubmit {
                  //  validate(userName: username, password: optionalPassword ?? "")
                //}
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .frame(width: 200, height: 30, alignment: .center)
                
                //Text(username)
                //    .foregroundColor(emailFieldIsFocused ? .red : .blue)
                }
                
                VStack(alignment: .leading, spacing: 2){
        
            SecureField("Password", text: passwordBinding, prompt: Text("Required"))
            .border(Color(UIColor.separator))
            .frame(width: 200, height: 30, alignment: .center)
                }
                Button(action: {
                    validate(userName: username, password: optionalPassword ?? "")
                }){
                        Text("Login")
                }
                
                Button(action: {
                    bookClubViewModel.bookClubViewState = BookClubViewState.createProfile
                }){
                        Text("Create Account")
                }
                
            }.padding().onAppear(){
                bookClubViewModel.bookClubViewState = BookClubViewState.login
                bookClubViewModel.activeBook = nil
            }
        }else if bookClubViewModel.bookClubViewState == BookClubViewState.home{
                HStack(alignment: .top, spacing: 0){
                Button("Profile"){
                    
                }
                 Spacer()
                   VStack{
                Text("eBookshelf").font(.largeTitle)
                        Text("Viewing: \(bookClubViewModel.books.count)")
                    }
                Spacer()
                    HStack{
                        Button("M (10)"){
                            
                        }
                            Button("?") {
                                isShowHint = true
                            }
                            .frame(alignment: .trailing)
                            .foregroundColor(.gray)
                            .alert(isPresented: $isShowHint) {
                                Alert(
                                    title: Text("Hint"),
                                    message: Text("* Double-Tap item from the list to enter Update Mode."
                                      + "\n* Slide-Left or Slide-Right to delete items.                                                                                         ")
                                )
                            }
                    }
                }
                ScrollView{
                    LazyVGrid(columns: [GridItem()], spacing: 10){
                        ForEach(bookClubViewModel.books) {bookItem in
                            BookListItemView(book:bookItem, deleteBookAction: bookClubViewModel.deleteBook, updateBookAction: bookClubViewModel.updateBook, ratingValueChangedAction: bookClubViewModel.onRatingChanged)
                                //.padding(0)
                                .onTapGesture {
                                tapCount += 1
                                if tapCount > 1 {
                                    tapCount = 0
                                    bookClubViewModel.activeBook = bookItem
                                    bookClubViewModel.bookClubViewState = BookClubViewState.view
                                }
                                    
                            }
                        }//.padding(0)
                    }//.padding(0)
                }.onAppear(perform: bookClubViewModel.getBooks)
            LazyVGrid(columns: [GridItem(),GridItem(), GridItem(), GridItem()]){
                
                Button("Wishlist➕")
                {
                    bookClubViewModel.bookClubViewState = BookClubViewState.add
                }.foregroundColor(.gray)
                Button("TBR")
                {
                    bookClubViewModel.bookClubViewState = BookClubViewState.add
                }.foregroundColor(.gray)
                Button("READ")
                {
                    bookClubViewModel.bookClubViewState = BookClubViewState.add
                }
                VStack{
                Text("SEARCH")
                    Text("🔎")
                }
                
            }.foregroundColor(.gray)
            //.frame(height: )
        }else if bookClubViewModel.bookClubViewState == BookClubViewState.add{
            AddUpdateView(bookModel: BookModel(), viewState: $bookClubViewModel.bookClubViewState)
        }else if bookClubViewModel.bookClubViewState == BookClubViewState.view{
            AddUpdateView(bookModel: bookClubViewModel.activeBook!, viewState: $bookClubViewModel.bookClubViewState)
        }else if bookClubViewModel.bookClubViewState == BookClubViewState.update{
            AddUpdateView(bookModel: bookClubViewModel.activeBook!, viewState: $bookClubViewModel.bookClubViewState)
        }else if bookClubViewModel.bookClubViewState == BookClubViewState.createProfile{
            AddUpdateReaderView(
                viewState: $bookClubViewModel.bookClubViewState,
                dataService: bookClubViewModel.dataService
            )
        }
    }
}

// Password handling
extension Binding where Value: ExpressibleByStringLiteral {
    func withDefault(_ defaultValue: Value) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { self.wrappedValue = $0 }
        )
    }
}

extension Binding where Value: Equatable {
    // A version for non-String optionals
    init(unwrapping optional: Binding<Value?>, defaultValue: Value) {
        self.init(
            get: { optional.wrappedValue ?? defaultValue },
            set: { optional.wrappedValue = $0 }
        )
    }
}

//MARK: Extention

enum BookClubViewState{
    case login, add, update, home, loginFailed, view, createProfile
}

extension BookClubView{
    class BookClubViewModel: ObservableObject{
        @Published var books = [BookModel]()
        
        let dataService: AppDataService

        
        @Published var activeBook: BookModel?
        @Published var reader: ReaderModel?
        
        //var ratingValueChangedAction: Binding<((Int?, Int?) -> Void)?>?
        
        var isAddingOrUpdating: Bool = false
        @Published var bookClubViewState: BookClubViewState = BookClubViewState.login{
            willSet(newValue) {
                print("myProperty is about to change from '\(bookClubViewState)' to '\(newValue)'")
                // You can set a breakpoint here to inspect the call stack
            }
            didSet(oldValue) {
                print("myProperty just changed from '\(oldValue)' to '\(bookClubViewState)'")
                // You can set a breakpoint here to inspect the call stack
            }
        }
        
        // View can be initialize with some other object during dependency injection
        // ViewModel can be initialized with some ojbect like other view models as needed for subviews/widgets/structs
        init(dataService: AppDataService, bookClubViewState:BookClubViewState = BookClubViewState.login){
            self.dataService = dataService
            //self.ratingValueChangedAction = new ratingValueChangedAction
            //getReaderProfile()
        }
        
//        // Convenience initializer for previews/tests that expect parameterless init
//        convenience init() {
//            self.init(dataService: AppDataService())
//        }
        
        /// This function can be used to configure with something
        ///
        func configure(with something: Any)
        {
        
        }
        
        func getReaderProfile(lastName:String) -> Void {
            dataService.getReaderInfo(lastName: lastName) { b in
                self.reader = b
                if b != nil {
                    self.bookClubViewState = .home
                } else {
                    self.bookClubViewState = .createProfile
                }
            }
        }
        
        
        func selectBook(id: Int) ->Void{
            let index = self.books.firstIndex(where: { $0.id == id})!
      
            activeBook = books[index]
           
        }
        
        func getBooks(){
            dataService.getBooks{b in
                self.books = b
            }
        }
        
        func deleteBook(id:Int){
            dataService.deleteBook(id: id){b in
                if b {
                    let index = self.books.firstIndex(where: { $0.id == id})!
                    self.books.remove(at: index)
                }
            }
        }
        
        func updateBook(id: Int){
            selectBook(id: id)
            self.bookClubViewState = BookClubViewState.update
//            dataService.deleteBook(id: id){b in
//                if b {
//                    let index = self.books.firstIndex(where: { $0.id == id})!
//                    self.books.remove(at: index)
//                }
//
//            }
        }
        
        
        func onRatingChanged(bookId: Int, oldValue: Int, newValue: Int){
           //print("oldValue = \(oldValue) newValue =\(newValue) ")
            selectBook(id: bookId)
            dataService.updateBook(book: activeBook!){b in
                            if b {
                                //let index = self.books.firstIndex(where: { $0.id == id})!
                                //self.books.remove(at: index)
                                
                            }
            }
            }
        }
}



    struct LoadingAlert: ViewModifier {
        @Binding var isShow: Bool
        var bookTitle: String

        func body(content: Content) -> some View {
           
            content.confirmationDialog("Are You Sure Delete \(bookTitle) ?", isPresented: $isShow, titleVisibility: .visible)
                {
                    Button("Delete", role: .destructive){ print("item Deleted")}
                }
        }
    }



struct BookThumbView: View{
    let book: BookModel
    @State private var dragCompleted = false
    @State private var dragOffset = CGSize.zero
    @State private var isShowingAlert = false
    

    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 10)
                shape.stroke(lineWidth: 1)
            VStack{
                Text(book.title).font(.body).foregroundColor(.blue)
                HStack{
                    HStack{
                        Text("Image Not Found")
                    }
                    Spacer()
                }
            }
            
                }
        GroupBox(label: Text("Label")) {
                                    Text("Content")
        }
        .contextMenu{
            Button{}label: {
                Label("Delete", systemImage: "trash")
        }
        }
    }
}


//extension BookThumbViewWithGesture{
//    class BookModel: ObservableObject{
//       // @Published var book = BookModel()
//    }
//}

struct UpdateBookView: View{
    @Environment(\.dismiss) var dismiss
    @ObservedObject var book: BookModel
    var body: some View{
        
        Text("UPDATE")
       // print("IN UPDATE")
        Button("Dismiss"){
            dismiss()
        }
    }
        
}




struct Delete: ViewModifier {
    
    let action: () -> Void
    
    @State var offset: CGSize = .zero
    @State var initialOffset: CGSize = .zero
    @State var contentWidth: CGFloat = 0.0
    @State var willDeleteIfReleased = false
   
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    ZStack {
                        Rectangle()
                            .foregroundColor(.red)
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                            .font(.title2.bold())
                            .layoutPriority(-1)
                    }.frame(width: -offset.width)
                    .offset(x: geometry.size.width)
                    .onAppear {
                        contentWidth = geometry.size.width
                    }
                    .gesture(
                        TapGesture()
                            .onEnded {
                                delete()
                            }
                    )
                }
            )
            .offset(x: offset.width, y: 0)
            .gesture (
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width + initialOffset.width <= 0 {
                            self.offset.width = gesture.translation.width + initialOffset.width
                        }
                        if self.offset.width < -deletionDistance && !willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        } else if offset.width > -deletionDistance && willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        }
                    }
                    .onEnded { _ in
                        withAnimation{
                        if offset.width < -deletionDistance {
                            delete()
                        } else if offset.width < -halfDeletionDistance {
                            offset.width = -tappableDeletionWidth
                            initialOffset.width = -tappableDeletionWidth
                        } else {
                            offset = .zero
                            initialOffset = .zero
                        }
                        }
                    }
            )
            
    }
    
    private func delete() {
        offset.width = -contentWidth
        action()
    }
    
    private func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    //MARK: Constants
    
    let deletionDistance = CGFloat(200)
    let halfDeletionDistance = CGFloat(50)
    let tappableDeletionWidth = CGFloat(100)
    
    
}

extension View {
    
//    func onDeleteItem(perform action: @escaping () -> Void) -> some View {
//        self.modifier(Delete(action: action))
//    }
    
//    func onUpdateItem(perform action: @escaping () -> Void) -> some View {
//        self.modifier(Update(action: action))
//    }
    
}




struct BookClub_Previews: PreviewProvider {
    static var previews: some View {
        let dataService = AppDataService()
        let bookClubViewModel = BookClubView.BookClubViewModel(dataService: dataService)
        //let addUpdateViewModel = AddUpdateViewModel(bookModel: bookClubViewModel.bookModel)
        let bookModel = BookModel()
        bookModel.author = "TestAuthor1"
        bookModel.title = "TestTitle1"
        bookModel.isbn = "ISBN123"
        bookModel.id = 1
        bookClubViewModel.books = [bookModel]
        
        return BookClubView(bookClubViewModel: bookClubViewModel)
            .environmentObject(dataService)
    }
}

