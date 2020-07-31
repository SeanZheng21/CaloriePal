//
//  MealSummaryView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/31/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct MealSummaryView: View {
    @ObservedObject var mealSummary: MealSummary
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Text("\(self.mealSummary.mealName.capitalized) Nutrients")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                    Button("Done") {
                        self.isPresented = false
                    }
                }
                .padding(.horizontal)
                
                HStack(alignment: .center) {
                    PieChartView(pieChartData: self.mealSummary.pieChartData())
                        .aspectRatio(1.0, contentMode: .fit)
                }
                .frame(width: geometry.size.width, height: MealSummaryView.pieChartHeight)
                
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Nutrient.fatColor)
                                .imageScale(.medium)
                            Text("Fat - \(Int(self.mealSummary.fatPercentage))%")
                            Spacer()
                            Text(Nutrient.formatNutrient(self.mealSummary.totalNutrient.fat) + "g")
                        }
                        HStack {
                            Text("          Saturated Fat")
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text(Nutrient.formatNutrient(self.mealSummary.totalNutrient.satFat) + "g")
                        }
                        HStack {
                            Text("    Cholesterol")
                            Spacer()
                            Text(Nutrient.formatNutrient(self.mealSummary.totalNutrient.cholesterol) + "mg")
                        }
                        HStack {
                            Text("    Sodium")
                            Spacer()
                            Text(Nutrient.formatNutrient(self.mealSummary.totalNutrient.sodium) + "mg")
                        }
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Nutrient.carbColor)
                                .imageScale(.medium)
                            Text("Carbonhydrates - \(Int(self.mealSummary.carbsPercentage))%")
                            Spacer()
                            Text(Nutrient.formatNutrient(self.mealSummary.totalNutrient.carbs) + "g")
                        }
                        HStack {
                            Text("          Fiber")
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text(Nutrient.formatNutrient(self.mealSummary.totalNutrient.fiber) + "g")
                        }
                        HStack {
                            Text("          Sugars")
                                .foregroundColor(Color.gray)
                            Spacer()
                            Text(Nutrient.formatNutrient(self.mealSummary.totalNutrient.sugars) + "g")
                        }
                        HStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Nutrient.proteinColor)
                                .imageScale(.medium)
                            Text("Protein - \(Int(self.mealSummary.proteinPercentage))%")
                            Spacer()
                            Text(Nutrient.formatNutrient(self.mealSummary.totalNutrient.protein) + "g")
                        }
                    }
                }
                .padding(.all)
                
                Text("\(self.mealSummary.mealName.capitalized): \(self.mealSummary.totalCalories) calories")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                VStack {
                    ForEach(self.mealSummary.foods, id: \.self.id) { food in
                        HStack {
                            Image(ImageStore.loadImage(name: food.name, imageExtension: "png"),
                                  scale: MealSummaryView.imageIconScale, label: Text(food.name))
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
                        }.padding(.horizontal)
                    }
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
                Spacer()
            }
            .padding(.top)
        }
    }
    
    // MARK: - Drawing Constants
    private static let imageIconScale: CGFloat = 2.0
    private static let pieChartHeight: CGFloat = 200
}

struct MealSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        MealSummaryView(mealSummary: MealSummary(meal: Meal(id: 1, type: .breakfast, foods: [foodData[0], foodData[1]])), isPresented: .constant(true))
    }
}
