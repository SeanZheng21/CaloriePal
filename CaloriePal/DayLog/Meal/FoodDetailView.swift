//
//  FoodDetailView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 7/28/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct FoodDetailView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var rootStore: RootStore
    @ObservedObject var dayLog: DayLog
    @ObservedObject var mealList: MealList
    @ObservedObject var foodDetail: FoodDetail
    
    var unitOptions: [String]
    @State private var selectedUnit: Int
    var integerOptions = [Int](0..<500).map({ String($0) })
    @State private var selectedInteger: Int
    var decimalOptions = ["-", "1/8", "1/4", "1/3", "1/2",
                            "2/3", "3/4", "7/8"]
    @State private var selectedDecimal: Int
    @State private var showServingSize = false
    
    init(foodDetail: FoodDetail, mealList: MealList, dayLog: DayLog) {
        self.foodDetail = foodDetail
        self.mealList = mealList
        self.dayLog = dayLog
        self.unitOptions = foodDetail.foodType.foodUnits().map { String($0.rawValue)}
        let (int, dec) = FoodDetail.getIntegerDecimalLevels(floatNumber: foodDetail.foodAnount.amount)
        _selectedDecimal = State(initialValue: dec)
        _selectedInteger = State(initialValue: int)
        _selectedUnit = State(initialValue: unitOptions.firstIndex(of: foodDetail.foodAnount.unit.rawValue) ?? 0)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Image(ImageStore.loadImage(name: self.foodDetail.foodName, imageExtension: "png"),
                              scale: self.imageIconScale, label: Text(self.foodDetail.foodName))
                        Text(self.foodDetail.foodName)
                            .font(.title)
                            .fontWeight(.heavy)
                        Spacer()
                    }.padding(.leading)
                    Divider()
                    HStack {
                        HStack {
                            VStack {
                                Text("\(self.foodDetail.foodCalorie)")
                                    .font(.system(size: self.foodDetail.foodCalorie<=1000 ? self.calorieFont : self.calorieSmallerFont, weight: .semibold))
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
                                Text(self.foodDetail.foodAnount.description)
                                Text(Nutrient.formatNutrient(self.foodDetail.foodNutrient.fat) + "g")
                                Text(Nutrient.formatNutrient(self.foodDetail.foodNutrient.satFat) + "g")
                                    .foregroundColor(Color.gray)
                                Text(Nutrient.formatNutrient(self.foodDetail.foodNutrient.cholesterol) + "mg")
                                Text(Nutrient.formatNutrient(self.foodDetail.foodNutrient.sodium) + "mg")
                                Text(Nutrient.formatNutrient(self.foodDetail.foodNutrient.carbs) + "g")
                                Text(Nutrient.formatNutrient(self.foodDetail.foodNutrient.fiber) + "g")
                                    .foregroundColor(Color.gray)
                                Text(Nutrient.formatNutrient(self.foodDetail.foodNutrient.sugars) + "g")
                                    .foregroundColor(Color.gray)
                                Text(Nutrient.formatNutrient(self.foodDetail.foodNutrient.protein) + "g")
                            }
                        }
                        .font(.system(size: 15))
                            .padding(.all, 20)
                    }
                    Divider()
                    Text("Amount")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.leading)
                    HStack {
                        Spacer(minLength: geometry.size.width/7)
                        Picker(selection: self.$selectedInteger, label: Text("")) {
                            ForEach(0 ..< self.integerOptions.count) { index in
                                Text(self.integerOptions[index]).tag(index)
                            }
                        }
                            .onReceive([self.selectedInteger].publisher.first(), perform: { value in
                                let (int, _) = FoodDetail.getIntegerDecimalLevels(floatNumber: self.foodDetail.foodAnount.amount)
                                if value != int {
                                    self.foodDetail.setAmount(intVal: value, decimalVal: self.selectedDecimal,
                                                              mealList: self.mealList, dayLog: self.dayLog, rootStore: self.rootStore)
                                }
                            })
                            .labelsHidden()
                            .frame(width: geometry.size.width/7, height: self.pickerHeight, alignment: .center)
                        Spacer(minLength: geometry.size.width/7)
                        Picker(selection: self.$selectedDecimal, label: Text("")) {
                            ForEach(0 ..< self.decimalOptions.count) { index in
                                Text(self.decimalOptions[index]).tag(index)
                            }
                        }
                            .onReceive([self.selectedDecimal].publisher.first(), perform: { value in
                                let (_, dec) = FoodDetail.getIntegerDecimalLevels(floatNumber: self.foodDetail.foodAnount.amount)
                                if value != dec {
                                    self.foodDetail.setAmount(intVal: self.selectedInteger, decimalVal: value,
                                                              mealList: self.mealList, dayLog: self.dayLog, rootStore: self.rootStore)
                                }
                            })
                            .labelsHidden()
                            .frame(width: geometry.size.width/7, height: self.pickerHeight, alignment: .center)
                        Spacer(minLength: geometry.size.width/7)
                        Picker(selection: self.$selectedUnit, label: Text("")) {
                            ForEach(0 ..< self.unitOptions.count) { index in
                                Text(self.unitOptions[index]).tag(index)
                            }
                        }
                            .onReceive([self.selectedUnit].publisher.first(), perform: { value in
                                if self.unitOptions[value].lowercased() != self.foodDetail.foodAnount.unit.rawValue {
                                    let (intInd, decIdx) = self.foodDetail.setUnit(unitVal: value, mealList: self.mealList,
                                                                                   dayLog: self.dayLog, rootStore: self.rootStore)
                                    self.selectedInteger = intInd
                                    self.selectedDecimal = decIdx
                                }
                            })
                            .labelsHidden()
                            .frame(width: geometry.size.width/7, height: self.pickerHeight, alignment: .center)
                        Spacer(minLength: geometry.size.width/7)
                    }
                    Spacer()
                        .frame(height: 60.0)
                    HStack {
                        
                        Text("Serving Size Guide")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                self.showServingSize.toggle()
                            }
                        }) {
                            Image(systemName: "chevron.right.circle")
                                .imageScale(.large)
                                .rotationEffect(.degrees(self.showServingSize ? 90 : 0))
                                .scaleEffect(self.showServingSize ? 1.5 : 1)
                                .padding()
                        }
                    }
                    if self.showServingSize {
                        ServingSizeView()
                            .frame(width: geometry.size.width, height: geometry.size.width / ServingSizeView.drawingAspectRatio, alignment: .center)
                            .transition(self.transition)
                    }
                    Spacer()
                }
                .padding(.top)
                .navigationBarTitle("Edit Food")
                .navigationBarItems(trailing: Button("Done"){
                    self.foodDetail.saveFood(to: self.mealList, dayLog: self.dayLog, rootStore: self.rootStore)
                    self.presentation.wrappedValue.dismiss()
                })
            }
        }
    }
    
    var transition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    // MARK: - Drawing Constants
    let imageIconScale: CGFloat = 1.5
    let calorieFont: CGFloat = 50
    let calorieSmallerFont: CGFloat = 35
    let caloriePadding: CGFloat = 30
    let pickerHeight: CGFloat = 100.0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(foodDetail: FoodDetail(food: foodData[2]),
                       mealList: MealList(meal:
                        Meal(id: 1, type: .breakfast, foods: [foodData[0], foodData[1]])), dayLog: DayLog(day: Day()))
    }
}
