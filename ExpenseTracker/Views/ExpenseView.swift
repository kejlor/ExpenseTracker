//
//  ExpenseView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 04/01/2022.
//

import SwiftUI

struct ExpenseView: View {
    
    let expense: ExpenseEntity
    @EnvironmentObject var vm: CoreDataViewModel
    
    var body: some View {
        HStack {
            Text("Expense title:")
            Text(expense.title ?? "unknown")
            Text("Money spent:")
            Text("\(expense.money)")
        }
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var expense = ExpenseEntity()
    static var previews: some View {
        ExpenseView(expense: expense)
    }
}
