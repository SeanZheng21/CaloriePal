//
//  FoodSelectorView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct FoodSelectorView: View {
    @State var searchText: String = ""
    @EnvironmentObject var rootStore: RootStore
    @ObservedObject var dayLog: DayLog
    @ObservedObject var mealList: MealList
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.top)
            Spacer()

            List(foodData.filter(
                { searchText.isEmpty ? true : $0.name.contains(searchText) }
            )) { food in
                NavigationLink(destination:
                    FoodDetailView(foodDetail: FoodDetail(food: food), mealList: self.mealList, dayLog: self.dayLog)
                        .environmentObject(self.rootStore)
                ) {
                    HStack {
                        Image(ImageStore.loadImage(name: food.name, imageExtension: "png"),
                              scale: FoodSelectorView.imageIconScale, label: Text(food.name))
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
        }.navigationBarTitle("Add To \(self.mealList.mealName)")
    }
    
    // MARK: - Drawing Constants
    private static let imageIconScale: CGFloat = 1.5
}

struct FoodSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        FoodSelectorView(searchText: "", dayLog: DayLog(day: Day()), mealList: MealList(meal:
            Meal(id: 1, type: .breakfast, foods: [foodData[0], foodData[1]])))
    }
}
