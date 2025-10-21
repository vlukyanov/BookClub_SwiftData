//
//  RatingPicker.swift
//  BookClub
//
//  Created by vlukyanov on 12/21/21.
//

import Foundation
import SwiftUI
import UIKit

struct RatingPickerView3: View{
    
    @ObservedObject var book: BookModel
    
    var label = ""
    let maxRating = 5
    var offRating = Image(systemName: "star.fill")
    var selectedRating = "⭐️"
    
    var body: some View{
        HStack{
            if label.isEmpty == false{
                Text(label)
            }
            
            ForEach(1..<maxRating + 1, id: \.self) { number in
                let feelingType = display(for: number)
                
                if feelingType.isImage{
                    (feelingType.item as! Image)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.2)){
                                book.feeling = number
                            }
                        }
                    
                }else{
                    (feelingType.item as! Text)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.2)){
                                book.feeling = number
                            }
                        }
                }
            }
        }
    }
    
    func display(for number: Int) -> (isImage: Bool, item: Any) {
        if number > book.feeling {
            return (true, offRating)
        } else {
            return (false, Text(selectedRating))
        }
    }
}


//struct ContentView: View {
//    var textView: some View {
//        Text("Hello, SwiftUI")
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .clipShape(Capsule())
//    }
//
//    var body: some View {
//        VStack {
//
//
//            Button("Save to image") {
//                let image = textView.snapshot()
//
//                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//            }
//        }
//    }
//}
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}


struct RatingPickerView: View{
    
    @Binding var rating: Int?
    var ratingValueChangedAction: ((Int, Int) -> Void)?
    var label = ""
    let maxRating = 5
    var offRating = Image(systemName: "star.fill")
    var selectedRating = "⭐️"
    
    // Initializer for optional Int binding (keeps default property values)
    init(rating: Binding<Int?>, ratingValueChangedAction: ((Int, Int) -> Void)? = nil, label: String = "") {
        self._rating = rating
        self.ratingValueChangedAction = ratingValueChangedAction
        self.label = label
    }
    
    // Convenience initializer to accept non-optional Int bindings
    init(rating: Binding<Int>, ratingValueChangedAction: ((Int, Int) -> Void)? = nil, label: String = "") {
        self._rating = Binding<Int?>(get: { rating.wrappedValue },
                                     set: { rating.wrappedValue = $0 ?? 0 })
        self.ratingValueChangedAction = ratingValueChangedAction
        self.label = label
    }
    
    var body: some View{
        let oldRating = rating
        
        HStack{
            if !label.isEmpty{
                Text(label)
            }
            
            ForEach(1..<maxRating + 1, id: \.self) { number in
                let feelingType = display(for: number)
                
                if feelingType.isImage{
                    (feelingType.item as! Image)
                        .padding(0).lineSpacing(0)
                        .frame(width: 20, height: 20, alignment: .center)
                        .fixedSize(horizontal: true, vertical: true)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.2)){
                                rating = number
                            }
                            
                            if ratingValueChangedAction != nil {
                                ratingValueChangedAction!(oldRating ?? 0, number)
                            }
                        }
                    
                }else{
                    (feelingType.item as! Text)
                        .padding(0).lineSpacing(0)
                        .frame(width: 20, height: 20, alignment: .center)
                        .fixedSize(horizontal: true, vertical: true)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.2)){
                                rating = number
                            }
                            
                            if ratingValueChangedAction != nil {
                                ratingValueChangedAction!(oldRating ?? 0, number)
                            }
                        }
                }
            }
        }
    }
    
    func display(for number: Int) -> (isImage: Bool, item: Any) {
        if number > (rating ?? 0) {
            return (true, offRating)
        } else {
            return (false, Text(selectedRating))
        }
    }
}

//struct RatingPickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        @StateObject var bookModel = BookModel()
//        bookModel.feeling = 4
//        bookModel.id = 1
//        return RatingPickerView(rating: $bookModel.feeling)
//    }
//}
