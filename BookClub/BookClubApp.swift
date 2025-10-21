//
//  BookClubApp.swift
//  BookClub
//
//  Created by vlukyanov on 12/6/21.
//

import SwiftUI
import SwiftData

@main
struct BookClubApp: App {
    let container: ModelContainer
    
    //@StateObject private var dataService: AppDataService
    //@StateObject private var viewModel: BookClubView.BookClubViewModel

    init() {
        let schema = Schema([Book.self])
        let config = ModelConfiguration("BookClub", schema: schema)
        do {
        container = try ModelContainer(for: schema, configurations: config)
        }catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
        
        //Option to create store at documents location
//        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "BookClub_SwiftData.store"))
//        do {
//            container = try ModelContainer(for: Book.self, configurations: config)
//        }catch {
//            fatalError("Failed to initialize ModelContainer: \(error)")
//        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        //print(URL.documentsDirectory.path())
//        let dataService = AppDataService()
//        _dataService = StateObject(wrappedValue: dataService)
//        _viewModel = StateObject(wrappedValue: BookClubView.BookClubViewModel(dataService: dataService))
    }

    var body: some Scene {
        WindowGroup {
            BookListView()
//            BookClubView(bookClubViewModel: viewModel)
//                .environmentObject(dataService)
        }
        .modelContainer(container)
        //.modelContainer(for: Book.self)
    }
}
