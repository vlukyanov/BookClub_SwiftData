//
//  ReadersListView.swift
//  BookClub
//
//  Created by vlukyanov on 12/24/21.
//

import Foundation
import SwiftUI

struct ReadersListItemView: View{
    @State var bookHistoryItems: [ReaderModel]

    var body: some View {
        ScrollView{
            LazyVGrid(columns: [GridItem()]){
                ForEach(bookHistoryItems) { reader in
                    VStack{
                        HStack(){
                            Label(reader.firstName + " " + reader.lastName,  systemImage: "person")
                            Spacer()
                            VStack{
                                // ReaderModel does not have a 'rating' property.
                                // Since the picker is disabled, pass a constant value.
                                RatingPickerView(rating: .constant(0))
                                    .disabled(true)
                                Text("June 6, 2021")
                            }
                            Divider()
                        }
                        .padding(0)
                        .lineSpacing(0)
                    }
                    .padding(0)
                }
            }
        } //.onAppear(perform: bookClubViewModel.getBooks)
    }
}

struct ReadersListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let reader = ReaderModel()
        reader.firstName = "Val"
        reader.id = 1
        reader.lastName = "last"

        let reader1 = ReaderModel()
        reader1.firstName = "Val2"
        reader1.id = 1
        reader1.lastName = "last2"

        let reader2 = ReaderModel()
        reader2.firstName = "Val3"
        reader2.id = 1
        reader2.lastName = "last3"

        return ReadersListItemView(bookHistoryItems: [reader, reader1, reader2])
    }
}
