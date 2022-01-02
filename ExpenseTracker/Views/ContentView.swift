//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 01/01/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    var body: some View {
        List {
            ForEach(vm.categories, id: \.self) { category in
                Text(category.title ?? "unknown title")
                
                ForEach(vm.expenses, id: \.self) { expense in
                    if expense.category == category {
                        HStack {
                            Text(expense.title ?? "unknown expense")
                            Text("\(expense.money)")
                        }
                    }
                }
            }
        }
        Button {
            vm.addCategory()
        } label: {
            Text("Add category")
        }
        Button {
            vm.addExpense()
        } label: {
            Text("Add expense")
        }
        Button {
            vm.deleteAllData()
        } label: {
            Text("Delete All")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
