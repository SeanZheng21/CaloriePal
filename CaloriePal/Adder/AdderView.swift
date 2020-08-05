//
//  AdderView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/3/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct AdderView: View {
    @ObservedObject var rootStore: RootStore
    @ObservedObject var adder: Adder
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Adder")
//                NavigationLink(destination:
//                    FoodSelectorView(searchText: "",
//                        dayLog: DayLog(day: self.rootStore.getOrCreateCurrentDay()),
//                        mealList: MealList(meal: self.rootStore.getToday().breakfast))) {
//                    Text("Breakfast")
//                }
            }
        }
        
    }
}

struct AdderView_Previews: PreviewProvider {
    static var previews: some View {
        AdderView(rootStore: RootStore(plan: Plan(from: Date(), to: Date(), startWeight: 157, goalWeight: 155, rate: 0.5)), adder: Adder())
    }
}
