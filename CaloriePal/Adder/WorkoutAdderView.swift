//
//  WorkoutAdderView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/5/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct WorkoutAdderView: View {
    @EnvironmentObject var rootStore: RootStore
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.top)
            Spacer()
            
            List(workoutData.filter(
                { searchText.isEmpty ? true : $0.name.contains(searchText) }
            )) { workout in
                NavigationLink(destination:
                    WorkoutDetailView(workoutDetail: WorkoutDetail(workout: workout),
                                      exerciseList: ExerciseList(exercise: self.rootStore.getToday().exercise),
                                      dayLog: DayLog(day: self.rootStore.getToday()))
                ) {
                    HStack {
                        Image(ImageStore.loadImage(name: workout.name, imageExtension: "png"),
                          scale: WorkoutAdderView.imageIconScale, label: Text(workout.name))
                            .padding(.trailing)
                        Text(workout.name.capitalized + " ")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("\(workout.caloriePerMinute) cals per min")
                            .font(.callout)
                            .fontWeight(.light)
                            .foregroundColor(Color.gray)
                    }
                }
            }
        }
            .navigationBarTitle("Add Workout")
    }
    
    // MARK: - Drawing Constants
    private static let imageIconScale: CGFloat = 1.5
}

struct WorkoutAdderView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutAdderView()
    }
}
