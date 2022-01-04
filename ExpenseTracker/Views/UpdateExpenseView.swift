//
//  UpdateExtenseView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 04/01/2022.
//

import SwiftUI

struct UpdateExpenseView: View {
    let expense: ExpenseEntity
    @EnvironmentObject var vm: CoreDataViewModel
    @Binding var isEditing: Bool
    @State private var titleTextField = ""
    @State private var moneyTextField = 0.0
    @State private var selectedDate = Date()
    @State private var selectedCategory = CategoryEntity()
    
    var body: some View {
        VStack {
            Text("Expense title:")
            TextField("Enter your expense title here...", text: $titleTextField)
                .onAppear {
                    titleTextField = expense.title ?? "unknown"
                }
            Text("Money spent:")
            TextField("Type book pages count here...", value: $moneyTextField, formatter: NumberFormatter())
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
                vm.updateExpense(entity: expense, title: titleTextField, money: moneyTextField, date: selectedDate, category: selectedCategory)
                vm.getExpenses()
                isEditing.toggle()
            } label: {
                Text("Update expense")
            }
        }
    }
}

struct UpdateExpenseView_Previews: PreviewProvider {
    static var expense = ExpenseEntity()
    static var previews: some View {
        UpdateExpenseView(expense: expense, isEditing: .constant(true))
    }
}
