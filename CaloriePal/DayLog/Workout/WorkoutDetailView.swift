//
//  WorkoutDetailView.swift
//  CaloriePal
//
//  Created by Carlistle ZHENG on 8/1/20.
//  Copyright © 2020 Carlistle ZHENG. All rights reserved.
//

import SwiftUI

struct WorkoutDetailView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var rootStroe: RootStore
    @ObservedObject var dayLog: DayLog
    @ObservedObject var workoutDetail: WorkoutDetail
    @ObservedObject var exerciseList: ExerciseList
    
    var hourOptions = [Int](0...5).map({ String($0) })
    var minuteOptions = [Int](0...59).map({ String($0) })
    @State private var selectedHour: Int
    @State private var selectedMinute: Int
    @State private var isExcluded: Bool
    
    init(workoutDetail: WorkoutDetail, exerciseList: ExerciseList, dayLog: DayLog) {
        self.workoutDetail = workoutDetail
        self.exerciseList = exerciseList
        self.dayLog = dayLog
        _selectedHour = State(initialValue: workoutDetail.workoutHour)
        _selectedMinute = State(initialValue: workoutDetail.workoutMinute)
        _isExcluded = State(initialValue: workoutDetail.workoutExcluded)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Image(ImageStore.loadImage(name: self.workoutDetail.workoutName, imageExtension: "png"),
                          scale: WorkoutDetailView.imageIconScale, label: Text(self.workoutDetail.workoutName))
                    Text(self.workoutDetail.workoutName)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.leading)
                
                Divider()
                Text("Duration")
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .padding(.leading)
                
                HStack {
                    Picker("", selection: self.$selectedHour) {
                        ForEach(0 ..< self.hourOptions.count) { index in
                            Text("\(self.hourOptions[index])")
                                .tag(index)
                        }
                    }
                        .onReceive([self.selectedHour].publisher.first(), perform: { value in
                            if value != self.workoutDetail.workoutHour {
                                self.workoutDetail.setDuration(newHour: value, newMinute: self.selectedMinute,
                                                               exerciseList: self.exerciseList, dayLog: self.dayLog, store: self.rootStroe)
                            }
                        })
                        .labelsHidden()
                        .frame(width: geometry.size.width/4, height: WorkoutDetailView.pickerHeight, alignment: .center)
                    Text(self.selectedHour == 1 ? "hour": "hours")
                    Picker("", selection: self.$selectedMinute) {
                    ForEach(0 ..< self.minuteOptions.count) { index in
                            Text("\(self.minuteOptions[index])")
                                .tag(index)
                        }
                    }
                        .onReceive([self.selectedMinute].publisher.first(), perform: { value in
                            if value != self.workoutDetail.workoutMinute {
                                self.workoutDetail.setDuration(newHour: self.selectedHour, newMinute: value,
                                                               exerciseList: self.exerciseList, dayLog: self.dayLog, store: self.rootStroe)
                            }
                        })
                        .labelsHidden()
                        .frame(width: geometry.size.width/4, height: WorkoutDetailView.pickerHeight, alignment: .center)
                    Text(self.selectedMinute == 1 ? "minute" : "minutes")
                }
                Spacer()
                    .frame(height: 60.0)
                Divider()
                HStack(alignment: .center) {
                    Text("\(self.workoutDetail.workoutCalories) calories burned")
                        .font(.title)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, WorkoutDetailView.calorieVerticalPadding)
                }
                .frame(width: geometry.size.width)
                Divider()
                VStack(alignment: .leading) {
                    Text("Options")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                        .padding(.bottom, WorkoutDetailView.leadingPadding)
                    HStack {
                        Image(systemName: "minus.circle")
                            .padding(.leading)
                            .imageScale(.medium)
  
                        Spacer()
                        Toggle("Exclude From Total", isOn: self.$isExcluded)
                            .onReceive([self.isExcluded].publisher.first()) { value in
                                self.workoutDetail.setExcluded(to: value, exerciseList: self.exerciseList, dayLog: self.dayLog, store: self.rootStroe)
                            }
                    }
                    .foregroundColor(.blue)
                }
                    .padding(.horizontal)
                Spacer()
            }
                .padding(.all)
                .navigationBarTitle("Edit Workout")
                .navigationBarItems(trailing: Button("Done"){
                    self.workoutDetail.saveWorkout(to: self.exerciseList, dayLog: self.dayLog, store: self.rootStroe)
                    self.presentation.wrappedValue.dismiss()
                })
        }
    }
    
    // MARK: - Drawing Constants
    static let leadingPadding: CGFloat = 15
    static let imageIconScale: CGFloat = 1.5
    static let pickerHeight: CGFloat = 100.0
    static let calorieVerticalPadding: CGFloat = 45
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let workoutDetail = WorkoutDetail(workout: workoutData[0])
        let exercise = Exercise(id: 1, workouts: [workoutData[0], workoutData[1]])
        return WorkoutDetailView(workoutDetail: workoutDetail, exerciseList: ExerciseList(exercise: exercise), dayLog: DayLog(day: Day()))
    }
}
