//
//  CoreDataManager.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 02/01/2022.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "ExpenseTracker")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("❌ Error loading core data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("❌ Error saving core data. \(error.localizedDescription)")
        }
    }
}
