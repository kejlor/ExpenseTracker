//
//  CoreDataViewModel.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 02/01/2022.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    @Published var categories: [CategoryEntity] = []
    @Published var expenses: [ExpenseEntity] = []
    
    
    
    func getCategories() {
        let request = NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
        
        let sort = NSSortDescriptor(keyPath: \CategoryEntity.title, ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            categories = try manager.context.fetch(request)
        } catch let error {
            print("❌ Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getExpenses() {
        let request = NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
        do {
            expenses = try manager.context.fetch(request)
        } catch let error {
            print("❌ Error fetching. \(error.localizedDescription)")
        }
    }
    
    func addCategory() {
        let newCategory = CategoryEntity(context: manager.context)
        newCategory.title = "Food"
        save()
    }
    
    func addExpense() {
        let newExpense = ExpenseEntity(context: manager.context)
        newExpense.title = "Pizza"
        newExpense.money = 10.50
        newExpense.date = Date.now
        newExpense.category = categories[0]
        save()
    }
    
    func save() {
        self.manager.save()
        self.getCategories()
        self.getExpenses()
    }
}
