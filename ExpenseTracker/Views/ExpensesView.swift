//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 01/01/2022.
//

import SwiftUI

struct ExpensesView: View {
    
    @EnvironmentObject var vm: CoreDataViewModel
    
    var body: some View {
        VStack {
            ZStack {
                List {
                    ForEach(vm.categories, id: \.self) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            CategoryView(category: category)
                        }
                        
                        ForEach(vm.expenses, id: \.self) { expense in
                            if expense.category == category {
                                NavigationLink(destination: ExpenseDetailView(expense: expense)) {
                                    ExpenseView(expense: expense)
                                }
                            }
                        }
                        .onDelete(perform: vm.deleteExpense)
                    }
                    .onDelete(perform: vm.deleteCategory)
                }
            }
            .navigationTitle("Expenses Tracker 💸")
            .navigationBarItems(
                leading: EditButton(),
                trailing: NavigationLink("Add", destination: AddCategoryView()))
            
            Button {
                vm.deleteAllData()
            } label: {
                Text("Delete All")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
