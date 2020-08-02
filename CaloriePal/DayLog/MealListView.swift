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
    @EnvironmentObject var dayLog: DayLog
    @State var showMealDetail = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(ImageStore.loadImage(name: "Meal", imageExtension: "png"),
                      scale: MealListView.imageIconScale, label: Text("Workout"))
                    .padding(.leading)
                Text("\(mealList.mealName.capitalized): \(mealList.totalCalories)")
                    .font(.system(size: MealListView.titleFont))
                    .fontWeight(.bold)
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                Spacer()
                NavigationLink(destination:
                    FoodSelectorView(mealList: mealList).environmentObject(self.dayLog)
                ) {
                    Image(systemName: "plus.circle")
                        .padding(.trailing)
                        .imageScale(.medium)
                }
            }
            .padding(.top)
            .onTapGesture {
                self.showMealDetail = true
            }
            .sheet(isPresented: $showMealDetail) {
                MealSummaryView(mealSummary: MealSummary(meal: self.mealList.getMeal()), isPresented: self.$showMealDetail)
            }
            if !mealList.foods().isEmpty {
                List {
                    ForEach(mealList.foods(), id: \.self.id) { food in
                        NavigationLink(destination:
                            FoodDetailView(foodDetail: FoodDetail(food: food), mealList: self.mealList)
                                .environmentObject(self.dayLog)
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
                    }.onDelete { (indexSet) in
                        self.mealList.deleteFood(at: indexSet, from: self.dayLog)
                    }
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
            } else {
               NavigationLink(destination:
                FoodSelectorView(mealList: self.mealList).environmentObject(self.dayLog)
                )  {
                    HStack {
                        Image(systemName: "plus.circle")
                            .padding(.horizontal)
                            .imageScale(.medium)
                        VStack(alignment: .leading) {
                            Text("Add Some Food Here!")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                            Text("Log all your food to get better result")
                                .font(.callout)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                    }
                }
            }
        }
        .frame(height: CGFloat(MealListView.titleHeight
            + CGFloat(max(1, self.mealList.foods().count)) * MealListView.itemHeight))
    }
    
    // MARK: - Drawing Constants
    private static let imageIconScale: CGFloat = 2.0
    private static let titleFont: CGFloat = 25
    private static let titleHeight: CGFloat = 60
    private static let itemHeight: CGFloat = 55
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(mealList: MealList(meal:
            Meal(id: 1, type: .breakfast, foods: [foodData[0], foodData[1]])))
    }
}
