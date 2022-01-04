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
            Text(expense.title ?? "unknown")
            Spacer()
            Text("💵 \(expense.money, specifier: "%.2f")")
        }
        .font(.body)
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var expense = ExpenseEntity()
    static var previews: some View {
        ExpenseView(expense: expense)
    }
}
