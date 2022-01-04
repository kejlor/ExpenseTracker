//
//  UpdateExtenseView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 04/01/2022.
//

import SwiftUI

struct EditExpenseView: View {
    let expense: ExpenseEntity
    @EnvironmentObject var vm: CoreDataViewModel
    @Binding var isEditing: Bool
    @State private var titleTextField = ""
    @State private var moneyTextField = 0.0
    @State private var selectedDate = Date()
    @State private var selectedCategory = CategoryEntity()
    
    var moneyTextFieldProxy: Binding<String> {
        Binding<String>(
            get: { String(format: "%.02f", Double(self.moneyTextField)) },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.moneyTextField = value.doubleValue
                }
            }
        )
    }
    var body: some View {
        VStack {
            Text("Expense title:")
            TextField("Enter your expense title here...", text: $titleTextField)
                .onAppear {
                    titleTextField = expense.title ?? "unknown"
                }
            Text("Money spent:")
            TextField("Number", text: moneyTextFieldProxy)
                .keyboardType(.numberPad).onAppear {
                    moneyTextField = expense.money
                }
            Text("Date of purchase:")
            DatePicker("", selection: $selectedDate).onAppear {
                selectedDate = expense.date ?? Date()
            }
            Text("Category:")
            Picker("Pick category of your purchase", selection: $selectedCategory) {
                ForEach(vm.categories, id: \.self) {
                    Text($0.title ?? "unknown")
                }
            }
            .onAppear {
                selectedCategory = expense.category ?? CategoryEntity()
            }
            Button {
                vm.editExpense(entity: expense, title: titleTextField, money: moneyTextField, date: selectedDate, category: selectedCategory)
                vm.getExpenses()
                isEditing.toggle()
            } label: {
                Text("Update expense")
            }
        }
    }
}

struct EditExpenseView_Previews: PreviewProvider {
    static var expense = ExpenseEntity()
    static var previews: some View {
        EditExpenseView(expense: expense, isEditing: .constant(true))
    }
}
