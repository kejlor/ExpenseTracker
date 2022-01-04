//
//  UpdateCategoryView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 04/01/2022.
//

import SwiftUI

struct EditCategoryView: View {
    
    let category: CategoryEntity
    @EnvironmentObject var vm: CoreDataViewModel
    @Binding var isEditing: Bool
    @State private var titleTextField = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Old title: ")
                Text(category.title ?? "unknown")
            }
            TextField("New category title...", text: $titleTextField)
                .onAppear {
                    titleTextField = category.title ?? "unknown"
                }
        }

        Button {
            vm.editCategory(entity: category, title: titleTextField)
            vm.getCategories()
            isEditing.toggle()
        } label: {
            Text("Update")
        }

    }
}

struct EditCategoryView_Previews: PreviewProvider {
    static var category = CategoryEntity()
    static var previews: some View {
        EditCategoryView(category: category, isEditing: .constant(true))
    }
}
