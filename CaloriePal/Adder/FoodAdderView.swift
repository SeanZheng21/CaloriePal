//
//  FoodAdderView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/5/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct FoodAdderView: View {
    @EnvironmentObject var rootStore: RootStore
    var mealTypeToAdd: MealType
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.top)
            Spacer()

            List(foodData.filter(
                { searchText.isEmpty ? true : $0.name.contains(searchText) }
            )) { food in
                NavigationLink(destination:
//                    FoodDetailView(foodDetail: FoodDetail(food: food), foodAdder: self.foodAdder, mealType: self.mealTypeToAdd)
                    FoodDetailView(foodDetail: FoodDetail(food: food), mealList: MealList(meal: self.rootStore.getToday().getMeal(of: self.mealTypeToAdd)), dayLog: DayLog(day: self.rootStore.getToday()))
                        .environmentObject(self.rootStore)
                ) {
                    HStack {
                        Image(ImageStore.loadImage(name: food.name, imageExtension: "png"),
                              scale: FoodAdderView.imageIconScale, label: Text(food.name))
                            .padding(.trailing)
                        VStack(alignment: .leading) {
                            Text(food.name.capitalized + " ")
                                .fontWeight(.semibold)
                            Text("\(food.calorie) cals per " + food.amount.description)
                                .font(.callout)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                    }
                }
            }
        }.navigationBarTitle("Add To \(self.mealTypeToAdd.rawValue.capitalized)")
    }
    
    // MARK: - Drawing Constants
    private static let imageIconScale: CGFloat = 1.5
}

struct FoodAdderView_Previews: PreviewProvider {
    static var previews: some View {
        FoodAdderView(mealTypeToAdd: .breakfast)
    }
}
