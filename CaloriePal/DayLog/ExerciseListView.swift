//
//  ExerciseListView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/1/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var exerciseList: ExerciseList
    @State var showExerciseDetail = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Exercise: \(exerciseList.totalCalories)")
                    .font(.system(size: ExerciseListView.titleFont))
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                NavigationLink(destination:
                    WorkoutSelectorView().environmentObject(self.exerciseList)
                ) {
                    Image(systemName: "plus.circle")
                        .padding(.trailing)
                        .imageScale(.medium)
                }
            }
            List {
                ForEach(exerciseList.workouts(), id: \.self.id) { workout in
                    NavigationLink(destination:
                        WorkoutDetailView(workoutDetail: WorkoutDetail(workout: workout))
                            .environmentObject(self.exerciseList)
                    ) {
                        HStack {
                            Image(ImageStore.loadImage(name: workout.name, imageExtension: "png"),
                                  scale: ExerciseListView.imageIconScale, label: Text(workout.name))
                                .padding(.trailing)
                            VStack(alignment: .leading) {
                                Text(workout.name.capitalized + " ")
                                    .fontWeight(.semibold)
                                Text("\(workout.durationDescription())")
                                    .font(.callout)
                                    .foregroundColor(Color.gray)
                            }
                            Spacer()
                            Text("\(workout.calories)")
                        }
                    }
                }.onDelete(perform: self.exerciseList.deleteWorkout)
            }
            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
        }
        .frame(height: CGFloat(ExerciseListView.titleHeight +
            CGFloat(self.exerciseList.workouts().count) * ExerciseListView.itemHeight))
    }
    
    // MARK: - Drawing Constants
    private static let imageIconScale: CGFloat = 2.0
    private static let titleFont: CGFloat = 25
    private static let titleHeight: CGFloat = 40
    private static let itemHeight: CGFloat = 55
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        let exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
        return ExerciseListView(exerciseList: ExerciseList(exercise: exercise))
    }
}
