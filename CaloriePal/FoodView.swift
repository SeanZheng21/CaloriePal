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
    var unitOptions = ["Each", "Ounce", "Pound"]
    @State private var selectdUnit: Int = 0
    var integerOptions = [Int](0..<500).map({ String($0) })
    @State private var selectdInteger: Int = 1
    var decimalOptions = ["-", "1/8", "1/4", "1/3", "1/2",
                            "2/3", "3/4", "7/8"]
    @State private var selectdDecimal: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Image(ImageStore.loadImage(name: self.food.name, imageExtension: "png"),
                          scale: self.imageIconScale, label: Text(self.food.name))
                    Text(self.food.name)
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                }.padding(.leading)
                HStack {
                    HStack {
                        VStack {
                            Text("\(self.food.calorie)")
                                .font(.system(size: self.calorieFont, weight: .semibold))
                            Text("Calories").fontWeight(.light)
                        }
                        .padding(.all, self.caloriePadding)
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
                            Text(self.food.amount.description)
                            Text(Nutrient.formatNutrient(self.food.nutrient.fat) + "g")
                            Text(Nutrient.formatNutrient(self.food.nutrient.satFat) + "g")
                                .foregroundColor(Color.gray)
                            Text(Nutrient.formatNutrient(self.food.nutrient.cholesterol) + "mg")
                            Text(Nutrient.formatNutrient(self.food.nutrient.sodium) + "mg")
                            Text(Nutrient.formatNutrient(self.food.nutrient.carbs) + "g")
                            Text(Nutrient.formatNutrient(self.food.nutrient.fiber) + "g")
                                .foregroundColor(Color.gray)
                            Text(Nutrient.formatNutrient(self.food.nutrient.sugars) + "g")
                                .foregroundColor(Color.gray)
                            Text(Nutrient.formatNutrient(self.food.nutrient.protein) + "g")
                        }
                    }
                    .font(.system(size: 15))
                        .padding(.all, 20)
                }
                Text("Amount")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.leading)
                HStack {
                    Picker(selection: self.$selectdInteger, label: Text("")) {
                        ForEach(0 ..< self.integerOptions.count) { index in
                            Text(self.integerOptions[index]).tag(index)
                        }
                    }
                        .labelsHidden()
                        .frame(width: geometry.size.width/3, height: 100, alignment: .center)
                    
                    Picker(selection: self.$selectdDecimal, label: Text("")) {
                        ForEach(0 ..< self.decimalOptions.count) { index in
                            Text(self.decimalOptions[index]).tag(index)
                        }
                    }
                        .labelsHidden()
                        .frame(width: geometry.size.width/3, height: 100, alignment: .center)
                    
                    Picker(selection: self.$selectdUnit, label: Text("")) {
                        ForEach(0 ..< self.unitOptions.count) { index in
                            Text(self.unitOptions[index]).tag(index)
                        }
                    }
                        .labelsHidden()
                        .frame(width: geometry.size.width/3, height: 100, alignment: .center)
                }
                Spacer()
            }
                .padding(.top)
        }
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
