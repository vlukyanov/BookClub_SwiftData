//
//  BookListItemView.swift
//  BookClub
//
//  Created by vlukyanov on 12/21/21.
//

//public extension AttributeDynamicLookup {
//    subscript<T: AttributedStringKey>(dynamicMember keyPath: KeyPath<AttributeScopes.MyFrameworkAttributes, T>) -> T {
//        return self[T.self]
//    }
//}
//Declaration
//@dynamicMemberLookup @frozen enum AttributeDynamicLookup

import Foundation
import SwiftUI

struct BookListItemViewTest: View{
    @ObservedObject var bookClubViewModel: BookClubView.BookClubViewModel

    var body: some View{
        VStack(alignment: .center, spacing: 0){
       Text("Welcome to book club")
        ScrollView{
            LazyVGrid(columns: [GridItem()])
            {
                ForEach(bookClubViewModel.books) {bookItem in
                    BookListItemView(book:bookItem, deleteBookAction: bookClubViewModel.deleteBook, updateBookAction: bookClubViewModel.updateBook, ratingValueChangedAction: bookClubViewModel.onRatingChanged)
                }.frame(height: 150)
            }.padding(.top)
        }.onAppear(perform: getBooks)
        }

    }
    
//    func onRatingValueChanged(oldValue: Int, newValue: Int)
//    {
//
//    }

    func getBooks()
    {
        let  bookModel = BookModel()
        bookModel.author = "b"
        bookModel.title = ""
        bookModel.isbn = "a"
        bookModel.description = "D"
        bookModel.id = 1

        let  bookModel1 = BookModel()
        bookModel1.author = "Tehfjhfjgjh gjhgjghhgjgh"
        bookModel1.title = "Teshjgj gjhgjghj hgjhgjhgjhgjhg"
        bookModel1.isbn = "ISBN1236787687"
        bookModel1.description = "Descripiong long osdfsd sdfkla skldjlk askj laskdl jkalsdjfl kjsldkfj lasdlj kasdj ksdlj fklkajlskj skejl ksldk fkjsdlkj skdjl jlskdflsl"
        bookModel1.id = 2



       // let books = [bookModel, bookModel1]

        bookClubViewModel.books.append(bookModel)
        bookClubViewModel.books.append(bookModel1)

        //bookClubViewModel.books.append(bookModel1)
    }
}

struct BookListItemView: View{
    @ObservedObject var book: BookModel

    var deleteBookAction: (Int) -> Void
    var updateBookAction: (Int) -> Void
    var ratingValueChangedAction: (Int, Int, Int) -> Void
    

    
    //let geometry: GeometryProxy
    @State private var dragCompleted = false
    @State private var dragOffset = CGSize.zero
    @State private var isShowingAlert = false
    @State private var x = CGFloat.zero
    @State private var y = CGFloat.zero
    let colorNormal = Color("bookThumb")
    @State var color = Color("bookThumb")
    
    @State var isDeleting = false
    @State var bookCurrentLocation = CGFloat.zero
    
    @State private var selectedFeeling = 0
    @State private var feelingPickerVisible: Bool = false

    @State private var isPressing = false
    
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1
    @State private var isDragging = false
    
    @State private var offset = CGSize.zero
    
    @State private var scaleUp = true
    @State var items = 90.0
 
    var body: some View {
        //let shape =
       // HStack{
        ZStack(alignment: .center){
           
            RoundedRectangle(cornerRadius: 15)
                .fill(color)
                //.shadow(color: .black.opacity(0.2), radius: 5, x:1, y:1)
                //.shadow(color: .black.opacity(0.7), radius: 10, x:-1, y:-1)
                //.frame(height: 80, alignment: .center)
                //.padding()
            //VStack(alignment: .leading, spacing: 0){
                                    HStack(alignment: .top){
                                        VStack{

                                            Image("TestBook")
                                                .resizable()
                                                .padding(.trailing, 2)
                                                .scaledToFit()
                                                .frame(height: 50)
                                           // }//.border(.black)//.padding()
                                            //VStack(alignment: .leading, spacing: 0){
                                             //   HStack(alignment: .top, spacing: 0){
                                              //      VStack(alignment: .leading, spacing: 0){
                                  
                                        }.border(.black, width: 1)
                                           
                                                                HStack(alignment: .top){
                                                                VStack(alignment: .leading){
                                                                                Text(book.title.isEmpty ? "< Title Missing >": book.title)
                                                                        .font(.body)
                                                                        .fontWeight(.regular)
                                                                                    .foregroundColor(.black)
                                                                                    //.frame(height: 60, alignment: .topLeading)
                                                                                    //.frame(he: 100, alignment:.topLeading)
                                                                                    .lineLimit(2)
                                                                                    //.frame(width: 300, alignment: .topLeading)
                                                                        //Divider()
                                                                        .padding(0)
                                                                        HStack(alignment: .top){
                                                                                 Text("By:").font(.footnote).fontWeight(Font.Weight.light).foregroundColor(.black)
                                                                            Text(book.author)
                                                                                //height: <#T##CGFloat?#>, alignment: <#T##Alignment#>)
                                                                                .font(.footnote).fontWeight(Font.Weight.light)
                                                                                .foregroundColor(.white)
                                                                                //.frame(width: 200, height: 30)
                                                                                .lineLimit(1)
                                                                                .padding(0)
                                                                                //.frame(width: 100)//, height: <#T##CGFloat?#>, alignment: <#T##Alignment#>)
                                                                        }.padding(0)
                                                                            .padding(.horizontal).border(.black, width: 1)
                                                                }.padding(0).border(.black, width: 1)
                                                                    Spacer()
                                                                   // VStack(alignment: .trailing, spacing: 0){
                                                                   // HStack(alignment: .top, spacing: 1){
                                                                        RatingPickerView(rating: $book.feeling, ratingValueChangedAction: onValueChanged).border(.black, width: 1)
                                                                   // }
                                                                    //HStack(alignment: .top){}
                                                                    
                                                                   // }.padding(0).border(.black, width: 1)
                                                                }.padding(0).border(.black, width: 1) //////////////////
                        //                                HStack(){
                        //                                    Text("By:").font(.footnote).fontWeight(Font.Weight.light).foregroundColor(.black)
                        //                                    Text(book.author).font(.footnote).fontWeight(Font.Weight.light).foregroundColor(.white).frame(width: 30,  alignment: .leading)
                        //                                }
                                                 //   }
                                               // }
                                           // }
                                          //  Spacer()
                                          //  VStack{
                                           //     HStack(alignment: .center, spacing: 0){
                                                    
                                          //      }
                                         //   }
                                       // }.padding(10)
                                    }.padding(0)
            .padding()
              //  .border(.black, width: 1)
            //.frame(minWidth: 200, idealWidth: 0, maxWidth: 0, minHeight: 0, idealHeight: 0, maxHeight: 0, alignment: .center)
        }//.padding(1)
    
        .offset(
                CGSize(width: dragOffset.width,
                       height: 0
                      )
                )

        .gesture(DragGesture()
            .onChanged { gesture in
            isDeleting = false
            dragOffset = gesture.translation
            x = gesture.location.x
            y = gesture.location.y
        }
                 
            .onEnded { gesture in
            bookCurrentLocation = self.y
            isDeleting = false
            withAnimation(Animation.easeOut(duration: 2)){
                color = Color.red
           dragOffset.width = dragOffset.width + 20
               // bookClubViewModel.deleteBook(book:book)
                
            }
            isShowingAlert = true
             
             }
        ).confirmationDialog("Are You Sure To Delete \(book.title) ?", isPresented: $isShowingAlert, titleVisibility: .visible){
                Button("Delete", role: .destructive){
                    isDeleting = true
                    withAnimation(Animation.easeIn(duration: 0.5)){
                        color = Color.gray
                       //if dragOffset.width > 0
                       // {
                      //     self.x =  300
                       //}else{
                           dragOffset.width =  500
                       //}
                        
                    }
                    self.deleteBookAction(book.id)
                    isDeleting = false
                    
                print("item Deleted")
                    
                }
                   
            Button("Abort", role: .cancel){
                
                withAnimation(Animation.easeIn){
                   dragOffset = .zero
                   color = colorNormal
                }
                print("item abort")
            }
        }
    }
    
    func onValueChanged(fromValue: Int, toValue: Int)
    {
        ratingValueChangedAction(book.id, fromValue, toValue)
    }
}

struct BookListItemViewTest_Previews: PreviewProvider {
    static var previews: some View {
        
        @EnvironmentObject var dataService: AppDataService
        let bookClubViewModel = BookClubView.BookClubViewModel(dataService: dataService)
        return BookListItemViewTest(bookClubViewModel: bookClubViewModel)
    }
}
