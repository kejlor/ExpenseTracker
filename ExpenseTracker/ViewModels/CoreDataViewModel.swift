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
        do {
            try manager.context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
        do {
            try manager.context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
        guard let index = indexSet.first else { return }
        let entity = categories[index]
        manager.container.viewContext.delete(entity)
        categories.remove(atOffsets: indexSet)
        save()
    }
    
    func deleteExpense(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = expenses[index]
        manager.container.viewContext.delete(entity)
        expenses.remove(atOffsets: indexSet)
        save()
    }
    
    func deleteAllData() {
        for category in categories {
            manager.context.delete(category)
            manager.container.viewContext.delete(category)
        }
        for expense in expenses {
            manager.context.delete(expense)
            manager.container.viewContext.delete(expense)
        }
        save()
    }
    
    func save() {
        self.manager.save()
    }
}
