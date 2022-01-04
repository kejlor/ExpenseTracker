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
    @Published var categories: [CategoryEntity] = [] {
        didSet {
            save()
        }
    }
    @Published var expenses: [ExpenseEntity] = [] {
        didSet {
            save()
        }
    }
    
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
    
    func addCategory(title: String) {
        let newCategory = CategoryEntity(context: manager.context)
        newCategory.title = title
        if !categories.isEmpty {
            categories.append(newCategory)
        }
        save()
    }
    
    func addExpense(title: String, money: Double, date: Date, category: CategoryEntity) {
        let newExpense = ExpenseEntity(context: manager.context)
        newExpense.title = title
        newExpense.money = money
        newExpense.date = date
        if !categories.isEmpty {
            newExpense.category = category
        }
        save()
    }
    
    func editCategory(entity: CategoryEntity, title: String) {
        entity.title = title
        getCategories()
        save()
    }
    
    func editExpense(entity: ExpenseEntity, title: String, money: Double, date: Date, category: CategoryEntity) {
        entity.title = title
        entity.money = money
        entity.date = date
        entity.category = category
        getCategories()
        save()
    }
    
    func deleteCategory(indexSet: IndexSet) {
        categories.remove(atOffsets: indexSet)
        save()
    }
    
    func deleteExpense(indexSet: IndexSet) {
        expenses.remove(atOffsets: indexSet)
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
    }
}
