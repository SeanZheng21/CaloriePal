//
//  FoodView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/28/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct FoodView: View {
    var food: Food
    var body: some View {
        VStack {
            HStack {
                Image(ImageStore.loadImage(name: food.name, imageExtension: "png"),
                      scale: imageIconScale, label: Text(food.name))
                Text(food.name)
                    .font(.title)
                    .fontWeight(.heavy)
                Spacer()
            }.padding(.leading)
            HStack {
                HStack {
                    VStack {
                        Text("\(food.calorie)")
                            .font(.system(size: calorieFont, weight: .semibold))
                        Text("Calories").fontWeight(.light)
                    }
                        .padding(.all, caloriePadding)
                }.padding()
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Amount")
                        Text("Total Fat")
                        Text("    Sat Fat")
                            .foregroundColor(Color.gray)
                        Text("Cholesterol")
                        Text("Sodium")
                        Text("Total Carbs")
                        Text("    Fiber")
                            .foregroundColor(Color.gray)
                        Text("    Sugars")
                            .foregroundColor(Color.gray)
                        Text("Protein")
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(food.amount.description)
                        Text(Nutrient.formatNutrient(food.nutrient.fat) + "g")
                        Text(Nutrient.formatNutrient(food.nutrient.satFat) + "g")
                            .foregroundColor(Color.gray)
                        Text(Nutrient.formatNutrient(food.nutrient.cholesterol) + "mg")
                        Text(Nutrient.formatNutrient(food.nutrient.sodium) + "mg")
                        Text(Nutrient.formatNutrient(food.nutrient.carbs) + "g")
                        Text(Nutrient.formatNutrient(food.nutrient.fiber) + "g")
                            .foregroundColor(Color.gray)
                        Text(Nutrient.formatNutrient(food.nutrient.sugars) + "g")
                            .foregroundColor(Color.gray)
                        Text(Nutrient.formatNutrient(food.nutrient.protein) + "g")
                    }
                }
                .font(.system(size: 15))
                    .padding(.all, 20)
            }
            
            
            
            
            Spacer()
        }
            .padding(.top)
    }
    
    // MARK: - Drawing Constants
    let imageIconScale: CGFloat = 1.5
    let calorieFont: CGFloat = 50
    let caloriePadding: CGFloat = 30
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView(food: foodData[0])
    }
}
