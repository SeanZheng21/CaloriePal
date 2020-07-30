//
//  MealListView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/30/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct MealListView: View {
    @ObservedObject var mealList: MealList
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(mealList.mealName.capitalized): \(mealList.totalCalories)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Image(systemName: "chevron.right")
                        .imageScale(.large)
                }
                List {
                    ForEach(mealList.foods(), id: \.self.id) { food in
                        NavigationLink(destination:
                            FoodDetailView(foodDetail: FoodDetail(food: food))
                                .environmentObject(self.mealList)
                        ) {
                            HStack {
                                Image(ImageStore.loadImage(name: food.name, imageExtension: "png"),
                                      scale: MealListView.imageIconScale, label: Text(food.name))
                                    .padding(.trailing)
                                VStack(alignment: .leading) {
                                    Text(food.name.capitalized + " ")
                                        .fontWeight(.semibold)
                                    Text(food.amount.description)
                                        .font(.callout)
                                        .foregroundColor(Color.gray)
                                }
                                Spacer()
                                Text("\(food.calorie)")
                            }
                        }
                    }.onDelete(perform: self.mealList.deleteFood)
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
                .navigationBarTitle("Date comes here", displayMode: .inline)
            }
        }
    }
    
    // MARK: - Drawing Constants
    private static let imageIconScale: CGFloat = 2.0
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(mealList: MealList(meal:
            Meal(id: 1, type: .breakfast, foods: [foodData[0], foodData[1]])))
    }
}
