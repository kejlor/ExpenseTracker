//
//  CategoryView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 04/01/2022.
//

import SwiftUI

struct CategoryView: View {
    
    let category: CategoryEntity
    @EnvironmentObject var vm: CoreDataViewModel
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            Text(category.title ?? "unknown")
        }
        .navigationBarItems(trailing: Button(action: {
            isEditing.toggle()
        }, label: {
            Text("Edit".uppercased())
        }))
        .sheet(isPresented: $isEditing) {
            EditCategoryView(category: category, isEditing: $isEditing)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var category = CategoryEntity()
    static var previews: some View {
        CategoryView(category: category)
    }
}
