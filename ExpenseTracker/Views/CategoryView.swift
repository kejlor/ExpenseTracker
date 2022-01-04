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
    
    var body: some View {
        VStack{
            Text(category.title ?? "unknown")
                .font(.title)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var category = CategoryEntity()
    static var previews: some View {
        CategoryView(category: category)
    }
}
