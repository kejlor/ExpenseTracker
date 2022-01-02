//
//  CoreDataViewModel.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 02/01/2022.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    @Published var categories: [CategoryEntity] = []
    @Published var expenses: [ExpenseEntity] = []
    
    init() {
        getCategories()
        getExpenses()
    }
    
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
        if !categories.isEmpty {
            categories.append(newCategory)
        }
        save()
        print(categories.count)
        print(expenses.count)
    }
    
    func addExpense() {
        let newExpense = ExpenseEntity(context: manager.context)
        newExpense.title = "Book"
        newExpense.money = 9.99
        newExpense.date = Date.now
        newExpense.category = categories[0]
        save()
    }
    
    func deleteCategory() {
        let category = categories[0]
        manager.context.delete(category)
        save()
    }
    
    func deleteExpense() {
        let expense = expenses[0]
        manager.context.delete(expense)
        save()
    }
    
    func deleteAllData() {
        for category in categories {
            manager.context.delete(category)
        }
        for expense in expenses {
            manager.context.delete(expense)
        }
        save()
    }
    
    func save() {
        self.manager.save()
        self.getCategories()
        self.getExpenses()
    }
}
