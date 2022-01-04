//
//  UpdateCategoryView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 04/01/2022.
//

import SwiftUI

struct UpdateCategoryView: View {
    
    let category: CategoryEntity
    @EnvironmentObject var vm: CoreDataViewModel
    @State private var titleTextField = ""
    
    var body: some View {
        HStack {
            Text("Old title: ")
            Text(category.title ?? "unknown")
        }
        TextField("New category title...", text: $titleTextField)
        Button {
            vm.updateCategory(entity: category, title: titleTextField)
        } label: {
            Text("Update")
        }

    }
}

struct UpdateCategoryView_Previews: PreviewProvider {
    static var category = CategoryEntity()
    static var previews: some View {
        UpdateCategoryView(category: category)
    }
}
