//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 01/01/2022.
//

import SwiftUI

struct ExpensesView: View {
    
    @EnvironmentObject var vm: CoreDataViewModel
    @State private var isAddingCategory = false
    @State private var isAddingExpense = false
    
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
                trailing: NavigationLink("Add category", destination: AddCategoryView(isAddingCategory: $isAddingCategory), isActive: $isAddingCategory))
            
            
            NavigationLink("Add expense", destination: AddExpenseView(isAddingExpense: $isAddingExpense), isActive: $isAddingExpense)
            
            Button {
                vm.deleteAllData()
            } label: {
                Text("Delete All")
            }
        }
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
            .environmentObject(CoreDataViewModel())
    }
}
