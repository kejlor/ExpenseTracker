//
//  DataView.swift
//  ExpenseTracker
//
//  Created by Bartosz Wojtkowiak on 04/01/2022.
//

import SwiftUI

struct DataView: View {
    @EnvironmentObject var vm: CoreDataViewModel
    @State private var money = 0.0

    var body: some View {
        Text("\(money)")
            .onAppear {
                money = vm.returnCostsValue()
            }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
