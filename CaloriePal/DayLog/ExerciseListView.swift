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
    @EnvironmentObject var dayLog: DayLog
    @State var showExerciseDetail = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(ImageStore.loadImage(name: "Workout", imageExtension: "png"),
                      scale: ExerciseListView.imageIconScale, label: Text("Workout"))
                    .padding(.leading)
                Text("Exercise: \(exerciseList.totalCalories)")
                    .font(.system(size: ExerciseListView.titleFont))
                    .fontWeight(.bold)
                Spacer()
                NavigationLink(destination:
                    WorkoutSelectorView(exerciseList: self.exerciseList)
                        .environmentObject(self.dayLog)
                ) {
                    Image(systemName: "plus.circle")
                        .padding(.trailing)
                        .imageScale(.medium)
                }
            }
            .padding(.top)
            if !exerciseList.workouts().isEmpty {
                List {
                    ForEach(exerciseList.workouts(), id: \.self.id) { workout in
                        NavigationLink(destination:
                            WorkoutDetailView(workoutDetail: WorkoutDetail(workout: workout), exerciseList: self.exerciseList)
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
                    }.onDelete { (indexSet) in
                        self.exerciseList.deleteWorkout(at: indexSet, from: self.dayLog)
                    }
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                }
            } else {
                NavigationLink(destination:
                    WorkoutSelectorView(exerciseList: self.exerciseList)
                        .environmentObject(self.dayLog)
                ) {
                    HStack {
                        Image(systemName: "plus.circle")
                            .padding(.horizontal)
                            .imageScale(.medium)
                        VStack(alignment: .leading) {
                            Text("Add Some Workouts Here!")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black)
                            Text("Exercise will help you burn some calories")
                                .font(.callout)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                    }
                }
            }
        }
        .frame(height: CGFloat(ExerciseListView.titleHeight +
            CGFloat(max(1, self.exerciseList.workouts().count)) * ExerciseListView.itemHeight))
    }
    
    // MARK: - Drawing Constants
    private static let imageIconScale: CGFloat = 2.0
    private static let titleFont: CGFloat = 25
    private static let titleHeight: CGFloat = 60
    static let itemHeight: CGFloat = 55
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        let exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
        return ExerciseListView(exerciseList: ExerciseList(exercise: exercise))
    }
}
