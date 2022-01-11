//
//  AddCategoryView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 04/01/2022.
//

import SwiftUI

struct AddCategoryView: View {
    
    @EnvironmentObject var vm: CoreDataViewModel
    @State private var textFieldText = ""
    @Binding var isAddingCategory: Bool
    
    var body: some View {
        VStack {
            Text("Category title:")
            TextField("Write category description here...", text: $textFieldText)
            Button {
                vm.addCategory(title: textFieldText)
                vm.getCategories()
                isAddingCategory.toggle()
            } label: {
                Text("Add")
            }
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(isAddingCategory: .constant(true))
    }
}
