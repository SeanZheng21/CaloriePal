//
//  WorkoutSelectorView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/1/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct WorkoutSelectorView: View {
    @State var searchText: String = ""
    @EnvironmentObject var dayLog: DayLog
    @ObservedObject var exerciseList: ExerciseList
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(.top)
            Spacer()
            
            List(workoutData.filter(
                { searchText.isEmpty ? true : $0.name.contains(searchText) }
            )) { workout in
                NavigationLink(destination:
                    WorkoutDetailView(workoutDetail: WorkoutDetail(workout: workout), exerciseList: self.exerciseList)
                        .environmentObject(self.exerciseList)
                ) {
                    HStack {
                        Image(ImageStore.loadImage(name: workout.name, imageExtension: "png"),
                          scale: WorkoutSelectorView.imageIconScale, label: Text(workout.name))
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

struct WorkoutSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        let exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
        return WorkoutSelectorView(exerciseList: ExerciseList(exercise: exercise))
    }
}
