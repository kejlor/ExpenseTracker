//
//  ExpenseDetailView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 04/01/2022.
//

import SwiftUI

struct ExpenseDetailView: View {
    
    let expense: ExpenseEntity
    @EnvironmentObject var vm: CoreDataViewModel
    
    var body: some View {
        VStack {
            Text("Expense title:")
            Text(expense.title ?? "unknown")
            Text("Money spent:")
            Text("\(expense.money)")
            Text("Date of purchase:")
            Text(expense.date ?? Date(), style: .date)
            Text("Category:")
            Text("\(expense.category?.title ?? "unknown")")
        }
    }
}

struct ExpenseDetailView_Previews: PreviewProvider {
    static var expense = ExpenseEntity()
    static var previews: some View {
        ExpenseDetailView(expense: expense)
    }
}