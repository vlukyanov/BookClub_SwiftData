//
//  PreviewContainer.swift
//  BookClub
//
//  Created by vlukyanov on 10/1/25.
//

import Foundation
import SwiftData
struct Preview {
    let container: ModelContainer
    init(_ models: any PersistentModel.Type...) {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let schema = Schema(models)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        }catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
        
        func addExamples(_ examples: [any PersistentModel]) {
            Task { @MainActor in
                examples.forEach { example in
                    container.mainContext.insert(example)
                }
            }
        }
}
