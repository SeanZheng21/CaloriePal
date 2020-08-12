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
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(alignment: .leading) {
                    Text("Add Meals")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.leading)
                    ForEach(MealType.allCases, id: \.self) { mealType in
                        HStack {
                            Image(ImageStore.loadImage(name: mealType.rawValue.capitalized, imageExtension: "png"),
                                  scale: AdderView.imageIconScale, label: Text("Meal"))
                                .padding(.leading)
                            NavigationLink(destination:
                                FoodAdderView(mealTypeToAdd: mealType)
                                    .environmentObject(self.rootStore)
                                ) {
                                    Text(mealType.rawValue.capitalized)
                                        .foregroundColor(Color.black)
                                    Spacer()
                            }
                        }
                    }
                    
                    Text("Add Workout")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.top, 40.0)
                        .padding(.leading)
                    HStack {
                        Image(ImageStore.loadImage(name: "Workout", imageExtension: "png"),
                              scale: AdderView.imageIconScale, label: Text("Meal"))
                            .padding(.leading)
                        NavigationLink(destination:
                            WorkoutAdderView()
                                .environmentObject(self.rootStore)
                            ) {
                                Text("Workout")
                                    .foregroundColor(Color.black)
                                Spacer()
                        }
                    }
                    Spacer()
                }
                    .padding(.all)
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    private static let imageIconScale: CGFloat = 1.0
}

struct AdderView_Previews: PreviewProvider {
    static var previews: some View {
        AdderView(rootStore: RootStore(plan: Plan(gender: true, height: 73, age: 23, activityLevel: 1, from: Date(), startWeight: 157, goalWeight: 155, rate: 0.5)))
    }
}
