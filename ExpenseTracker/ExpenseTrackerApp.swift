//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 01/01/2022.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    @StateObject var vm = CoreDataViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ExpensesView()
            }
            .environmentObject(vm)
        }
    }
}
