//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 01/01/2022.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
