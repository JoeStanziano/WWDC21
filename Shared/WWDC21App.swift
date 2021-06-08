//
//  WWDC21App.swift
//  Shared
//
//  Created by Joe Stanziano on 6/8/21.
//

import SwiftUI

@main
struct WWDC21App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NewsList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
