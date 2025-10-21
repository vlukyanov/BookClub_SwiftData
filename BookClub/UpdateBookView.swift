//
//  UpdateBookView.swift
//  BookClub
//
//  Created by vlukyanov on 12/22/21.
//

import Foundation
import SwiftUI

struct DetailEditView: View {
    @State private var data = BookModel()
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $data.title)
                HStack {
//                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
//                        Text("Length")
//                    }
//                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
//                    Spacer()
                    Text("\(data.title) minutes")
                        .accessibilityHidden(true)
                }
            }
            Section(header: Text("Attendees")) {
//                ForEach(data.attendees) { attendee in
//                    Text(attendee.name)
//                }
//                .onDelete { indices in
//                    data.attendees.remove(atOffsets: indices)
//                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
//                        withAnimation {
//                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
//                            data.attendees.append(attendee)
//                            newAttendeeName = ""
//                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}
