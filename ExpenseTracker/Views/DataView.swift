//
//  DataView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 08/01/2022.
//

import SwiftUI

struct DataView: View {
    
    @EnvironmentObject var vm: CoreDataViewModel
    @State private var allCosts = 0.0
    
    var body: some View {
        Text("All money spent: \(allCosts, specifier: "%.2f")")
            .onAppear {
                getAllCosts()
            }
    }
    
    func getAllCosts() {
        for expense in vm.expenses {
            allCosts += expense.money
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
